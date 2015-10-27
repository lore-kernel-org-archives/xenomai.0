Date: Tue, 27 Oct 2015 13:32:39 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20151027133239.6304c872@md1em3qc>
In-Reply-To: <1445949050-10486-1-git-send-email-henning.schild@siemens.com>
References: <1445948976-10396-1-git-send-email-henning.schild@siemens.com>
 <1445949050-10486-1-git-send-email-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v3] scripts: use mktemp instead of relying on
 TMPDIR beeing in env
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Sorry for the mess. The 3rd adds the --tmpdir switch, that is the diff
to the first two. The v2 is not different from v1 because i did not
ammend before sending the mail.

Henning

On Tue, 27 Oct 2015 13:30:50 +0100
Henning Schild <henning.schild@siemens.com> wrote:

> The environment variable TMPDIR is optional and not always set. We
> could test for it and fall back to /tmp/ or just use the tool mktemp.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  scripts/prepare-kernel.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> index 8e960e8..d7a2cc6 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -238,9 +238,9 @@ fi
>  # Create an empty output patch file, and initialize the temporary
> tree. if test "x$output_patch" != "x"; then
>  
> -    temp_tree=$TMPDIR/prepare-kernel-$$
> -    if ! mkdir $temp_tree; then
> -	echo Temporary directory $temp_tree already exists, aborting.
> +    temp_tree=$( mktemp -d prepare-kernel-XXX --tmpdir )
> +    if [ $? -ne 0 ]; then
> +	echo Temporary directory could not be created.
>  	exit 1
>      fi
>  


