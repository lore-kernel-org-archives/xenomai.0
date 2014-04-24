MIME-Version: 1.0
In-Reply-To: <53583DF7.3080700@xenomai.org>
References: <CAPRPZsBD_5ufxFAhPCFqRf9YZSm1FhqfcmL+MTbhJ=1Sb7ED_g@mail.gmail.com>
 <CAPRPZsBsOmiaWPJmPR9RK0uv_BXbw_s43rarKOvVoGfN2gWZjQ@mail.gmail.com>
 <CAPRPZsCnAJH_-070SbSMB+Q_dQwf+FYfKpmp1wzwtz=zMA2bcA@mail.gmail.com>
 <5357C92F.2060206@xenomai.org>
 <CAPRPZsAvxx9XVB5MYi65m1FPaz2p7Rgh7+M4U357exJBbo0kHQ@mail.gmail.com>
 <535828F6.6050308@xenomai.org>
 <CAPRPZsA4ZQEm1a+2TV6s2wvD2_M53RrL4zLz0sJgLKEF8ALo1w@mail.gmail.com>
 <53583DF7.3080700@xenomai.org>
Date: Thu, 24 Apr 2014 10:57:34 +0200
Message-ID: <CAPRPZsB8a=gN=U14qn_tpfksg3T8yW+M8pZGhOkT-jPDuU8L0w@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Reading /proc/xenomai/stat causes high latencies
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> Could you put a printk in the function vfile_stat_rewind to see if it
> gets called (more than once) when the problem happens?

I patched as follows:

static int vfile_stat_rewind(struct xnvfile_snapshot_iterator *it)
{
    struct vfile_stat_priv *priv =3D xnvfile_iterator_priv(it);
    int irqnr;
    int ret, irq;

    /*
     * The activity numbers on each valid interrupt descriptor are
     * grouped under a pseudo-thread.
     */
    priv->curr =3D getheadq(&nkpod->threadq);
    irq =3D priv->irq;
    priv->irq =3D 0;
    irqnr =3D xnintr_query_init(&priv->intr_it) * XNARCH_NR_CPUS;

    ret =3D irqnr + countq(&nkpod->threadq);

    printk(KERN_DEBUG "%s: priv=3D%p, ->curr=3D%p, ->irq=3D(%d), irqnr=3D%d=
, ret=3D%d\n",
           __FUNCTION__, priv, priv->curr, irq, irqnr, ret);

    return ret;
}


The result (3 first accesses are without latency running, the 2 last
ones with latency running - each time 120 =C2=B5s delay)

[  173.098667] vfile_stat_rewind: priv=3Dffff880211863228,
->curr=3Dffffffffa06b1110, ->irq=3D(0), irqnr=3D256, ret=3D264
[  181.547424] vfile_stat_rewind: priv=3Dffff880211863b28,
->curr=3Dffffffffa06b1110, ->irq=3D(0), irqnr=3D256, ret=3D264
[  183.002400] vfile_stat_rewind: priv=3Dffff880211863228,
->curr=3Dffffffffa06b1110, ->irq=3D(0), irqnr=3D256, ret=3D264
[  201.475071] vfile_stat_rewind: priv=3Dffff880211863228,
->curr=3Dffffffffa06b1110, ->irq=3D(0), irqnr=3D256, ret=3D266
[  209.432070] vfile_stat_rewind: priv=3Dffff8802118631a8,
->curr=3Dffffffffa06b1110, ->irq=3D(0), irqnr=3D256, ret=3D266


So vfile... is called exactly once upon issuing 'cat /proc/xenomai/stat'.


Jeroen.

