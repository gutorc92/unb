from django.shortcuts import render
from django.views import View
from .forms import FileFieldForm

def handle_uploaded_file(f, name):
    with open(name, 'wb+') as destination:
        for chunk in f.chunks():
            destination.write(chunk)

class CreateGallery(View):

    def post(self, request):
        print(request)
        print(request.FILES)
        files = request.FILES.getlist('file_field')
        print(files)
        form = FileFieldForm(request.POST, request.FILES)
        if form.is_valid():
            print("Passou aqui")
            handle_uploaded_file(request.FILES['file'], "/home/gustavo/Documents/image")
            return self.get(request)

        else:
            return render(request, "gallery/create.html",{'form': form})
     
    def get(self, request):
        form = FileFieldForm()
        return render(request, "gallery/create.html",{'form': form})
        

# Create your views here.
