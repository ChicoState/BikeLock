# Generated by Django 3.0.3 on 2020-03-24 23:02

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('WebApp', '0007_auto_20200324_2259'),
    ]

    operations = [
        migrations.AlterField(
            model_name='station',
            name='ip',
            field=models.GenericIPAddressField(null=True),
        ),
    ]