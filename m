Date: Sat, 28 Nov 2015 07:43:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151128064325.GC10399@hermes.click-hack.org>
References: <trinity-3a616500-d86a-4f71-bb11-16fa1d6cf8a2-1448533977790@3capp-webde-bs12>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <trinity-3a616500-d86a-4f71-bb11-16fa1d6cf8a2-1448533977790@3capp-webde-bs12>
Subject: Re: [Xenomai] "RT throttling" issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: JK.Behnke@web.de
Cc: xenomai@xenomai.org

On Thu, Nov 26, 2015 at 11:32:57AM +0100, JK.Behnke@web.de wrote:
> Hello,
> =A0
> in my xenomai 2.6.3 application I sporadically experience very long execu=
tion times of
> a task that switches back and forth between secondary and primary mode.
> =A0
> I added the following code to measure elapsed and cpu time
> //------------- start code snippet ---------------
> struct rusage rsgT1;
> struct rusage rsgT2;
> struct timeval tvT1;
> struct timeval tvT2;
> gettimeofday(&tvT1, NULL);

Do you observe the same problem with Xenomai 2.6 git head, if you
use clock_gettime(CLOCK_HOST_REALTIME) instead of gettimeofday, at
least for threads running in primary mode ?=20

--=20
					    Gilles.
https://click-hack.org

