Message-ID: <4E8B0DEA.8030102@domain.hid>
Date: Tue, 04 Oct 2011 15:45:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAGc_wL0GYwEPJVMOBR_niJCd9bz2VWoTA7-q-MLOAR_WW2vm2g@domain.hid>	<4E8AEB1D.2060706@domain.hid>
	<CAGc_wL11cKQhxRmgYB0wU-bFii3YaqjibjgWB+=Tob3tFjsfQQ@mail.gmail.com>
In-Reply-To: <CAGc_wL11cKQhxRmgYB0wU-bFii3YaqjibjgWB+=Tob3tFjsfQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel configuration suggestions/hints
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Julien Delange <julien.delange@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 10/04/2011 03:06 PM, Julien Delange wrote:
> void polling_task(void * arg)
> {
>    int                      i;
>    double                tmp;
>    int                     ret;
>    uint8_t               raw[128 * 16];
>    double               rate = 0.0001;

Your "rate" looks more like a period to me (that is, the reciprocal).
The corresponding rate would be 10000.

>    int                      result;
>    unsigned long     missed;
>    a4l_insn_t          insn_tab[16];
>    a4l_insnlst_t       insnlst;
> 
> 
>    insnlst.count = 16;
>    insnlst.insns = insn_tab;
> 
>    for (i=0; i<16; i++)
>    {
>       insn_tab[i].type             = A4L_INSN_READ;
>       insn_tab[i].idx_subd      = 0;
>       insn_tab[i].chan_desc   = chdesc[i];
>       insn_tab[i].data_size     = 8;
>       insn_tab[i].data             = &raw[128 * i];
>    }
>    rt_task_set_periodic(NULL, TM_NOW, rate * 1000000000.0);

1000000000.0 * 0.0001 is 100000, that is 100us, not 1ms. As of why you
get 2ms (or 200us, maybe ?) is still a mystery. Could you send us your
kernel configuration?
Are not the analogy calls blocking?

-- 
					    Gilles.

