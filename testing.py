import unittest
from Transcription import Transcription
from Translation import Protein
from rna_transformation import RNA

class CentralDogma(unittest.TestCase):
    pepsin_gene = Transcription('pepsin_gene.txt')
    pepsin_mrna = RNA(pepsin_gene.sequence)
    pepsin_peptide = Protein(pepsin_mrna.mrna_trans())
    
    def test_transcription(self):
        self.assertEqual(self.pepsin_gene.get_bpcount(),3038) #this number is the actual number of basepairs from NCBI, this lets me know that the transcribe method works well as well
    
    def test_translation(self):
        self.assertEquals(self.pepsin_peptide.aa_count(),20) #this is the number of amino acids from NCBI, indicative that the design of the translation method worked well
        
    
    
if __name__ == '__main__':
    unittest.main()
