from Bio import SeqIO

rec = SeqIO.index_db(snakemake.input["fdb"])
rec = rec[snakemake.params["acc"]]
if snakemake.params["pid"]:
    feature = next(
        ele
        for ele in rec.features
        if ele.type == "CDS" and ele.qualifiers["protein_id"][0] == snakemake.params["pid"]
    )
    rec = feature.extract(rec)
    rec.id = snakemake.params["pid"]
    product = feature.qualifiers.get("product", ["n/a"])[0]
    rec.description = f"{rec.id}|{feature.location} {product}"

SeqIO.write(rec, snakemake.output.ffa, "fasta")
SeqIO.write(rec, snakemake.output.ffg, "genbank")
