from django.contrib import admin
from django.urls import path
from django.http import HttpResponse

def index(request):
    return HttpResponse("<h1>Welcome to the Level Up Developer Experience Demo!</h1><p>Your Django app is running successfully with Kubernetes!</p>")

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', index, name='index'),
]
