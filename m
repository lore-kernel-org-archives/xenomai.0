Message-ID: <4B4F0A8A.7060106@domain.hid>
Date: Thu, 14 Jan 2010 13:14:02 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <1263470867-1533-1-git-send-email-wg@domain.hid>	<1263470867-1533-2-git-send-email-wg@domain.hid>	<1263470867-1533-3-git-send-email-wg@domain.hid>	<1263470867-1533-4-git-send-email-wg@domain.hid>
	<1263470867-1533-5-git-send-email-wg@domain.hid>
In-Reply-To: <1263470867-1533-5-git-send-email-wg@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH xenomai-2.5 3/3] rtcan: mscan: new
 OF	platform driver for MPC521x and MPC5200
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

Wolfgang Grandegger wrote:
> pdir=../send-rtcan-mscan-mpc5xxx/
> sprefix="PATCH xenomai-2.5"
> commitid=b197fe0f370d92ee1838b370fbf927ca50a0e573
> subject="rtcan: mscan: new OF platform driver for MPC521x and MPC5200"
> blurb="\
> This patch series adds RT-Socket-CAN support for the MSCAN on the MPC512x\\
> from Freescale by introducing a new OF platform driver for both, the\\
> MPC521x and MPC5200, while still keeping the old driver for the MPC5200\\
> for compatibility with older kernel versions.\\
> \\
> Wolfgang"
> 
> rm -f $pdir/*.patch
> mkdir $pdir
> opt="--dry-run"
> test "$1" = "send" && opt=""
> 
> git format-patch -n -o $pdir --cover-letter --subject-prefix="$sprefix" \
>     $commitid
> 
> mv $pdir/0000-cover-letter.patch /tmp/0000-cover-letter.patch
> sed "
> s/\*\*\* SUBJECT HERE \*\*\*/$subject/
> s/\*\*\* BLURB HERE \*\*\*/$blurb/
> " /tmp/0000-cover-letter.patch > $pdir/0000-cover-letter.patch
> 
> echo "====================================================================="
> cat $pdir/0000-cover-letter.patch
> echo "====================================================================="
> 
> opt="--dry-run"
> test "$1" = "send" && opt=""
> 
> git format-patch -o $pdir --subject-prefix="$sprefix" $commitid
> 
> echo "opt=$opt"
> git send-email $opt \
>     --to "Xenomai-core@domain.hid" \
>     --from="Wolfgang Grandegger <wg@domain.hid>" \
>     $pdir

s/$pdir/$pdir/*.patch/

Grrr, due to that mistake in my git-patch-prepare-and-send script, the
script file (and backup) has also been sent to the list as well. Please
ignore the last two patch. Sorry for the noise

Wolfgang.


