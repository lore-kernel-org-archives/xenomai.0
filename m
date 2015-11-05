Date: Thu, 5 Nov 2015 11:31:28 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20151105113128.0179dae2@md1em3qc>
In-Reply-To: <20151104075311.GG24848@hermes.click-hack.org>
References: <20151028105140.GA26607@hermes.click-hack.org>
 <1446030916-6963-1-git-send-email-henning.schild@siemens.com>
 <20151104075311.GG24848@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v4] scripts: use mktemp instead of relying on
 TMPDIR beeing in env
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, 4 Nov 2015 08:53:11 +0100
Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:

> On Wed, Oct 28, 2015 at 12:15:16PM +0100, Henning Schild wrote:
> > The environment variable TMPDIR is optional and not always set. We
> > could test for it and fall back to /tmp/ or just use the tool
> > mktemp.
> > 
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> >  scripts/prepare-kernel.sh | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> > index 8e960e8..333d11c 100755
> > --- a/scripts/prepare-kernel.sh
> > +++ b/scripts/prepare-kernel.sh
> > @@ -238,9 +238,9 @@ fi
> >  # Create an empty output patch file, and initialize the temporary
> > tree. if test "x$output_patch" != "x"; then
> >  
> > -    temp_tree=$TMPDIR/prepare-kernel-$$
> > -    if ! mkdir $temp_tree; then
> > -	echo Temporary directory $temp_tree already exists,
> > aborting.
> > +    temp_tree=`mktemp -d prepare-kernel-XXX --tmpdir`
> > +    if [ $? -ne 0 ]; then
> > +	echo Temporary directory could not be created.
> >  	exit 1
> >      fi
> 
> The version of mktemp installed on my machine requires 6 X in the
> template.

That is unfortunate but easy enough to fix. The patch has already been
applied, so we will need another one on top. I suggest you go ahead and
expand the template since you found the problem.
The man-pages on my boxes all say "at least 3".

Henning

