import rna_transformation
class Protein:
    #the class takes a mrna list and converts into a protein chain and performs small analyses on the protein
    #these dictionaries aid in fetching the corresponding the amino acid or STOP signal during translation
    stop_dict = {'UAA': 'Stop', 'UAG': 'Stop', 'UGA':'Stop'}
    aa_dict = {'AUG': 'Met', 'UUU': 'Phe', 'UUC':'Phe', 'UUA': 'Leu', 'UUG': 'Leu', 
               'UCU':'Ser', 'UCC': 'Ser', 'UCA':'Ser', 'UCG': 'Ser', 'UAU':'Tyr', 
               'UAC':'Tyr', 'UGU': 'Cys', 'UGC': 'Cys', 'UGG': 'Trp', 'CUU': 'Leu', 
               'CUC':'Leu', 'CUA': 'Leu', 'CUG': 'Leu', 'CCU': 'Pro', 'CCC': 'Pro',
               'CCA': 'Pro', 'CCG': 'Pro', 'CAU': 'His', 'CAC':'His', 'CAA': 'Gln',
                'AUU': 'Ile', 'AUC': 'Ile', 'AUA': 'Ile', 'ACU': 'Thr', 'ACC': 'Thr',
                'ACA':'Thr', 'ACG': 'Thr', 'AAU': 'Asn', 'AAC': 'Asn', 'AAA': 'Lys',
                'AAG': 'Lys', 'AGU': 'Ser', 'AGC': 'Ser', 'AGA': 'Arg', 'AGG': 'Arg',
                'CGU': 'Arg', 'CGC': 'Arg', 'CGA': 'Arg', 'CGG': 'Arg', 'GUU': 'Val',
                'GUC': 'Val', 'GUA': 'Val', 'GUG': 'Val', 'GCU': 'Ala', 'GCC': 'Ala',
                'GCA':'Ala', 'GCG': 'Ala', 'GAU': 'Asp', 'GAC': 'Asp', 'GAA': 'Glu',
                'GAG': 'Glu', 'GGU': 'Gly', 'GGC': 'Gly', 'GGA': 'Gly', 'GGG': 'Gly'}
    def __init__(self, codondict):
        self.codondict = codondict
        self.peptide = self.translation(codondict)
        
    def get_codon(self):
        #the trna codon dictionary
        return self.codondict
    
    def get_peptidechain(self):
        #returns the list of amino acids that make up the amino acid 
        return (self.peptide)
    
    def aa_count(self):
        #this return the amount of amino acids 
        return len(self.get_peptidechain())
    
    def translation(self, codondict):
        peptide_chain = []
        for codon in codondict:
            if codon in self.stop_dict:
                break
            else:
                peptide_chain.append(self.aa_dict.get(codon))
        return peptide_chain
    
    def mw_weight(self):
        #this method calculates the molecular weight of the protein in kilodaltons.
        mw = 0
        mw_dict = {'Ala': 71.0788, 'Arg': 156.1875, 'Asn': 114.1038 , 'Asp': 115.0886, 
                   'Cys': 103.1388, 'Glu': 129.1155, 'Gln': 128.1307, 'Gly': 57.0519,
                   'His': 137.1411, 'Ile': 113.1594, 'Leu': 113.1594, 'Lys': 128.1741,
                    'Met': 131.1926, 'Phe': 147.1766, 'Pro': 97.1167, 'Ser': 87.0782,
                    'Thr': 101.1051, 'Trp': 186.2132, 'Tyr': 163.1760, 'Val': 99.1326}
        for aa in self.get_peptidechain():
            if aa is not None:
                mw += mw_dict.get(aa,0)         
        kda = mw/ 1000
        return kda
    
    def absorbance(self): #this formula only works if the protein is at pH 6.5,
        #this calculates the optical density of the protein
        cys_count = (self.get_peptidechain().count('Cys'))/2
        tyr_count = (self.get_peptidechain().count('Tyr'))/2
        trp_count = (self.get_peptidechain().count('Trp'))/2
        ext_coeff = (cys_count * 120) + (tyr_count * 1280) + (trp_count * 5690)
        absorbance = ext_coeff/ self.mw_weight() 
        return absorbance
        
    
    def neg_charge(self): #this calculates how many negtive charges it can provide insight on cellular location of negative charges
        neg_charge = self.get_peptidechain().count('Asp') + self.get_peptidechain().count('Glu')
        return neg_charge
    
    def __str__(self):
        peptide_str = '-'.join(aa if aa is not None else 'X' for aa in self.get_peptidechain())
        return "This peptide chain is {}\nIt weighs {:2f} kDa and it has {} total negatively charged residue(s) and {} amino acids.\nThe absorbance is {:.2f} at a wavelength of 280 nm".format(peptide_str, self.mw_weight(), self.neg_charge(), self.aa_count(), self.absorbance())
    
        
