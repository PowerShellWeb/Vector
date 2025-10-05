@{
    "runs-on" = "ubuntu-latest"    
    if = '${{ success() }}'
    steps = @(
        @{
            name = 'Check out repository'
            uses = 'actions/checkout@main'
        },                
        'RunEZOut' #  ,
        <#@{
            name = 'Run Vector (on branch)'
            if   = '${{github.ref_name != ''main''}}'
            uses = './'
            id = 'VectorAction'
        }#>
        # 'BuildAndPublishContainer'
    )
}