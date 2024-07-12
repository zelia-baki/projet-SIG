from flask import Flask, jsonify, request, send_file
import psycopg2
import pyqrcode
from io import BytesIO

app = Flask(__name__)

# Etablir la connexion PostgreSQL
conn = psycopg2.connect(
    dbname="carte_visite",
    user="postgres",
    password="manitrafitia",
    host="localhost"
)

# Route pour tester la connexion
@app.route('/')
def index():
    cur = conn.cursor()
    cur.execute('SELECT version()')
    db_version = cur.fetchone()
    cur.close()
    return jsonify(db_version)

# Route POST pour l'insertion de données
@app.route('/send', methods=['POST'])
def envoi():

    data = request.json

    nom = data.get('nom')
    emploi = data.get('emploi')
    tel = data.get('tel')
    mail = data.get('mail')
    site = data.get('site')
    adresse = data.get('adresse')
    logo = data.get('logo')

    try:
        cur = conn.cursor()
        cur.execute(
            '''INSERT INTO carte (nom, emploi, tel, mail, site, adresse, logo)
               VALUES (%s, %s, %s, %s, %s, %s, %s);''',
            (nom, emploi, tel, mail, site, adresse, logo)
        )
        conn.commit()
        cur.close()

        return jsonify({'message': 'Donnée insérée avec succès'})

    except Exception as e:

        conn.rollback()
        return jsonify({'error': str(e)}), 500

@app.route('/read', methods=['GET'])
def lire():
    try:
        cur = conn.cursor()
        cur.execute(
            ''' SELECT nom, emploi, tel, mail, site, adresse, logo FROM
                carte '''
        )

        data = cur.fetchall()

        conn.commit()
        cur.close()

        return jsonify({'message': 'Données récupérées avec succès', 'data': data})
    
    except Exception as e:

        conn.rollback()
        return jsonify({'error': str(e)}), 500

@app.route('/read/<int:id>', methods=['GET'])
def lire_un(id):
    try:
        cur = conn.cursor()
        cur.execute(
            '''SELECT nom, emploi, tel, mail, site, adresse, logo 
               FROM carte 
               WHERE id = %s''',
            (id,)
        )

        data = cur.fetchone() 

        if not data:
            return jsonify({'error': 'Enregistrement non trouvé'}), 404

        cur.close()

        return jsonify({'message': 'Enregistrement trouvé', 'data': data})

    except Exception as e:
        conn.rollback()
        return jsonify({'error': str(e)}), 500


@app.route('/qr/<int:id>', methods=['GET'])
def qr(id):
    try:
        cur = conn.cursor()
        cur.execute(
            '''SELECT nom, emploi, tel, mail, site, adresse, logo 
               FROM carte 
               WHERE id = %s''',
            (id,)
        )

        data = cur.fetchone()

        if not data:
            return jsonify({'error': 'Enregistrement non trouvé'}), 404

        cur.close()

        qr_data = f"Nom: {data[0]}\nEmploi: {data[1]}\nTel: {data[2]}\nMail: {data[3]}\nSite: {data[4]}\nAdresse: {data[5]}\nLogo: {data[6]}"
        qr = pyqrcode.create(qr_data)

        qr_img = BytesIO()
        qr.png(qr_img, scale=8)

        qr_img.seek(0)

        return send_file(qr_img, mimetype='image/png')

    except Exception as e:
        conn.rollback()
        return jsonify({'error': str(e)}), 500


if __name__ == '__main__':
    app.run(debug=True)
