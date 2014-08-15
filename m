Message-ID: <53EDCCFE.5030900@xenomai.org>
Date: Fri, 15 Aug 2014 11:03:58 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAEGbdidABiixUba3TiheYcLx1Swh5TrTbt_FtenZsExq7weUYg@mail.gmail.com>
 <53E93A3D.2060403@nta-inc.net> <53ED39DC.5030504@xenomai.org>
In-Reply-To: <53ED39DC.5030504@xenomai.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] C++ std::thread and xenomai pthread
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jorge Ramirez Ortiz <jro@xenomai.org>, xenomai@xenomai.org

On 08/15/2014 12:36 AM, Jorge Ramirez Ortiz wrote:
> On 08/11/2014 05:48 PM, Jeff Webb wrote:
>> On 08/11/2014 10:33 AM, Matthew Lindner wrote:
>>> Has anyone experimented with using std::thread from the C++ STL library=
? I
>>> am curious if it automatically incorporates the xenomai pthread API lay=
er
>>> or whether it bypasses that and accesses the linux pthread library.
> =

>> Yes, I've tried this and it has worked for me.
> =

> some years ago I presented this at XUM 2009.
> Some of the recommendations are no longer valid - user space drivers for =
instance
> (this project was before RTDM) - but we did use Xenomai to successfully d=
eploy a
> large scale C++ software project.
> http://www.denx.de/en/pub/News/Xum2009AbstractsAndPresentations/Xenomai_a=
nd_Realtime_Image_Processing_Control.pdf
>

Thanks for reminding me, I have referenced this material from our
website at http://xenomai.org/start-here/#Other_readings.

Btw, user-space drivers in dual kernel mode are ok with Xenomai 3, and
will have actually better support from the core system with the newly
introduced RTDM-based UDD driver (UIO-like base), than Xenomai 2 could
offer with the obsolete pthread_intr and rt_intr APIs.

-- =

Philippe.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 246 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140815/dbf1841=
b/attachment.sig>
