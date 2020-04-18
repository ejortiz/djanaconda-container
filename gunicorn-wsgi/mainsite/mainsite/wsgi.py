import os
import sys

path = '/opt/www/django-apps/mainsite'
if path not in sys.path:
    sys.path.append(path)

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "mainsite.settings")

from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()