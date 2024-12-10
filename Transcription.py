import os 
import string
class Transcription:
    #this class takes a DNA file and converts it into a MRNA list and performs small analyses on the DNA
    mw_dict = {'A': 331.2, 'T': 322.2, 'C': 307.2, 'G': 347.2, 'U': 160.9} #nucleotide molecular weight
    def __init__(self, file):
        self.__file = file
        self.sequence = self.transcribe(self.__file)
        self.base_pair = self.__calculate_bp(self.sequence)

    def transcribe(self,file): #takes dna file and removes all and adds each  single nucleotide to a list called sequence
        sequence = []
        try:
            with open(file, 'r') as gene:
                for line in gene:
                    line = line.translate(str.maketrans('', '', string.punctuation))
                    line = line.translate(str.maketrans('', '', string.digits))
                    line = line.strip()
                    line = line.upper()
                    line = line.replace('T', 'U')
                    temp_list = line.split()
                    for ch in temp_list:
                        sequence.extend(ch)                                                  
        except FileNotFoundError as e:
            return str(e)
        return sequence
    
    def get_bpcount(self):
        return self.base_pair
                
    def __calculate_bp(self,sequence): #returns the total number of nucleotides
        return len(sequence)
    
    def molecular_weight(self,sequence): #calculates the molecular weight of the sequence
        mw = 0
        for bp in sequence:
            mw += self.mw_dict.get(bp)
        return mw
            
    def gc_content(self,sequence): #calculates the GC Content, tells how easy it is to annel the primer to DNA
         gc = ((sequence.count('G') + sequence.count('C'))/ self.get_bpcount()) *100
         return 'GC Content is {:.2f}%'.format(gc)
    def get_seq(self):
        return self.sequence
    def __str__(self):
        return "This gene has a basepair count of {}, {} and a molecular weight of {:.2f} g/mol".format(self.get_bpcount(),self.gc_content(self.sequence),self.molecular_weight(self.sequence))