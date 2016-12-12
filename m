References: <CAD6zzEn4imLcrGfSu-Ehrs_L3Kyf3DM_Fhb4NuQREZ4xszbxpg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <c0e1bcb9-3f9c-3427-a7ac-584f713ec39c@xenomai.org>
Date: Mon, 12 Dec 2016 17:00:16 +0100
MIME-Version: 1.0
In-Reply-To: <CAD6zzEn4imLcrGfSu-Ehrs_L3Kyf3DM_Fhb4NuQREZ4xszbxpg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] hrtimer negative next event
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marco Baracchi <cormabara@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/20/2015 11:53 AM, Marco Baracchi wrote:
> We are using kernel *linux 3.0.35*, branch *imx_3.0.35_4.1.0* with
> patches *adeos-xenomai
> 2.6.4* for *mxc* on a freescale imx6 single core and we have  a problem
> with hrtimer: sometimes after a couple of hour our periodic task inside
> Xenomai blocks. checking inside /proc path we  found:


Your kernel+xenomai combo is severely outdated, many issues fixed in
later I-pipe and Xenomai releases are present in your code base - not to
speak of Freescale's 3.0.35 imx vendor kernel itself. For the issue at
hand, I would at the very least backport this fix to the pipeline:

https://git.xenomai.org/ipipe.git/commit/?h=ipipe-3.14&id=9a54331043f450636613e9edb2a5a41fe424c6ff

Alternatively, you may want to disable NO_HZ_IDLE and see if this has a
positive impact on the stability of the system.

-- 
Philippe.

