import string
import Transcription
class RNA():
    #this class takes a mrna list and converts it into a trna tuple
    def __init__(self, mrna):
        self.mrna = mrna
        
    def get_mrna(self):
        return (self.mrna)
      
    def mrna_trans(self): #turns mrna into codon tuple
        codon_list = []
        mrna_string = ''.join(self.get_mrna())
        start_index = mrna_string.find('AUG') #frame to start reading sequence 
        for bp in range(start_index,len(mrna_string),3):
            codon = mrna_string[bp:bp+3]
            codon_list.append(codon)
        return tuple(codon_list)
    
    def __str__(self):
        return "The MRNA Sequence is {}".format(self.mrna_trans())