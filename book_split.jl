using CSV
using DataFrames

stem = "pml2"
out_dir = mkpath("out/$stem")
input_pdf = "in/$stem.pdf"

df = DataFrame(CSV.File("in/$stem.csv"))

for i in 1:size(df,1)
    r = df[i,:] # row
    chapter_name = lpad(r["Chapter"],2,"0") * "_" * r["Title"]
    cmd = `qpdf $input_pdf --pages . $(r["Real page start"])-$(r["Real page end"]) -- $out_dir/$chapter_name.pdf`
    run(cmd)    
end
