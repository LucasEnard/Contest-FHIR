from grongier.pex import BusinessService

from dataclass_csv import DataclassReader

from obj import BaseOrganization
from msg import OrgaRequest

import os

class ServiceCSV(BusinessService):

    def get_adapter_type():
        """
        Name of the registred adaptor
        """
        return "Ens.InboundAdapter"

    def on_init(self):
        """
        It changes the current path to the file to the one specified in the path 
        attribute of the object, or to '/irisdev/app/misc/' if no path attribute
        is specified
        :return: None
        """
        if not hasattr(self,'path_in'):
            self.path_in = '/irisdev/app/data/in/'
        if not hasattr(self,'path_out'):
            self.path_out = '/irisdev/app/data/out/'
        if not hasattr(self,'filename'):
            self.filename = 'Organization.csv'
        if not hasattr(self,'fhir_type'):
            self.fhir_type = BaseOrganization
        return None

    def on_tear_down(self):
        """
        On tear down, move the Organization.csv file to the misc folder ( not 
        working right now so you need to move the file by yourself )

        :return: None
        """
        os.rename(self.path_out + self.filename  , self.path_in + self.filename)
        return None

    def on_process_input(self,request):
        """
        It reads the organization.csv file, creates an OrgaRequest message for 
        each row following the BaseOrganization dataclass, and sends it to the
        Python.ProcessCSV process.
        
        :param request: the request object
        :return: None
        """
        try:
            with open(self.path_in + self.filename,encoding="utf-8") as csv:
                reader = DataclassReader(csv, self.fhir_type ,delimiter=";")
                for row in reader:
                    msg = OrgaRequest()
                    msg.organization = row
                    self.send_request_sync('Python.ProcessCSV',msg)

            # Once the file is read, it is moved to the used folder
            os.rename(self.path_in + self.filename, self.path_out + self.filename)

        except FileNotFoundError as e:
            pass

        return None

