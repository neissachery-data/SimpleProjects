from Transcription import Transcription
from Translation import Protein
from rna_transformation import RNA

if __name__ == '__main__':
    glucoseoxidase_gene = Transcription('gene_Lasiodiplodia theobromae.txt')
    glucoseoxidase_mrna = RNA(glucoseoxidase_gene.get_seq())
    glucoseoxidase_peptide = Protein(glucoseoxidase_mrna.mrna_trans())
    glucoseoxidase_dogma = set[glucoseoxidase_gene.__str__, glucoseoxidase_mrna.__str__(), glucoseoxidase_peptide.__str__()]
    pepsin_gene = Transcription('pepsin_gene.txt')
    pepsin_mrna = RNA(pepsin_gene.get_seq())
    pepsin_peptide = Protein(pepsin_mrna.mrna_trans())
    pepsin_dogma = set[pepsin_gene.__str__(),pepsin_mrna.__str__(),pepsin_peptide.__str__()]
    print(pepsin_dogma)
    print('\n')
    print('\n')
    print(glucoseoxidase_gene)
    
    