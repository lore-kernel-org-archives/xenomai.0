Date: Mon, 3 Nov 2014 19:53:12 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141103185312.GC13799@sisyphus.hd.free.fr>
References: <20141103162457.GF9327@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676297E@SINTEFEXMBX05.sintef.no>
 <20141103164433.GG9327@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C67629F0@SINTEFEXMBX05.sintef.no>
 <20141103170220.GH9327@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C6762A5E@SINTEFEXMBX05.sintef.no>
 <20141103171338.GI9327@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C6762AC3@SINTEFEXMBX05.sintef.no>
 <20141103172746.GK9327@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C6762C3E@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C6762C3E@SINTEFEXMBX05.sintef.no>
Subject: Re: [Xenomai] Xenoma 2.6.4 missing posix/xeno_config.h ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Terje =?utf-8?Q?Fr=C3=B8ysa?= <Terje.Froysa@sintef.no>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Nov 03, 2014 at 06:42:54PM +0000, Terje Frøysa wrote:
> Thanks again Gilles!
> 
> I am now trying to compile an application using only native calls and using --skin=native
> The reference to rt_task_shadow  is now found, but the rt_dev_open and rt_dev_close are still missing.
> I expect that the code should reside in the librtdm files, but have no documentation on this.

Same answer, rt_dev_open/rt_dev_close are part of the rtdm skin, so
you have to run xeno-config with the --skin=rtdm to get the flags
for this skin. xeno-config is documented, try xeno-config --help to
see the available skin.


> Can you recommend a document that can lecture me in this subject?
> I have tried to find such documentation, but the information is scattered and the examples cannot easily be put together (by novices) without conflicts.
> I have downloaded the:
> "Xenomai Native skin API.pdf" 
> "Xenomai Posix skin Api.pdf" 
> "Xenomai nanokernel API.pdf"
> "Xenomai_RTDM-and-Applications.pdf"
> "Xenomai RTDM skin API.pdf"
> 
> I find a lot of doxygen generated html-files, but they don’t give me the pedagogical contextual fill-ins.
> I really dislike bothering people with such basic questions....

There is no documentation per-se, but the behaviour of xeno-config
is consistent enough that you should be able to guess what to do...

-- 
					    Gilles.

