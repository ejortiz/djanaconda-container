Common issues:

Copying of the modified wsgi does not get copied over, so you need to manually add

path = '/var/www/django-apps/mainsite/mainsite'
if path not in sys.path:
    sys.path.append(path)

to the top of the file