##
# ZSTYLES
#

zstyle ":completion:*:descriptions" format "%B%d%b"
# zstyle ":completion::complete:export:*" fake AWS_PROFILE:'The AWS Profile to use with the AWS CLI'
zstyle ":completion::complete:export:*" fake-parameters AWS_PROFILE:scalar
