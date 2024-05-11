from django.shortcuts import render
from django.http import HttpResponse

def getscript(request):
    with open('crawlers/info_crawler.sh', 'r') as file:
        scripttext = file.read()
    return HttpResponse(scripttext, content_type="text/plain")
