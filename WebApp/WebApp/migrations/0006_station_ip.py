# Generated by Django 3.0.3 on 2020-03-24 22:58

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('WebApp', '0005_auto_20200322_0215'),
    ]

    operations = [
        migrations.AddField(
            model_name='station',
            name='ip',
            field=models.GenericIPAddressField(default=None),
        ),
    ]