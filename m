From: Marcel Van Mierlo <Marcel.VanMierlo@marel.com>
Date: Mon, 6 Jun 2016 08:14:45 +0000
Message-ID: <AM4PR05MB17470B585705C4680E3DF0EC915C0@AM4PR05MB1747.eurprd05.prod.outlook.com>
References: <AM4PR05MB17479649FDCD91F251E66DB991740@AM4PR05MB1747.eurprd05.prod.outlook.com>,
 <37e28fa0-0e14-6b84-dc43-e0f64c16c226@xenomai.org>
In-Reply-To: <37e28fa0-0e14-6b84-dc43-e0f64c16c226@xenomai.org>
Content-Language: en-GB
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] what limits number of pSOS tasks using t_create?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>


Hi Philippe, yes that worked.

I made a regression test on the maximum number of psos threads I could crea=
te. I found that once I start seeing ERR_NOTCB returned from t_create the m=
aximum number of tasks I can create then drops, even after deleting all pre=
vious tasks - as if available memory for tasks becomes less after limit is =
hit.

For example, after tuning all four parameters below (including CONFIG_XENO_=
OPT_REGISTRY_NRSLOTS) I am able to reliably create 500 tasks under test con=
ditions - if I push it to 600, say, and see ERR_NOTCB, then after deleting =
all tasks I can only create a maximum of around 300 tasks.

This is fine for me - I know I will never need more than 150 tasks, but see=
ms something worth noting.



Cheers,
Marcel.
________________________________________
From: Philippe Gerum <rpm@xenomai.org>
Sent: 02 June 2016 14:44:44
To: Marcel Van Mierlo; xenomai@xenomai.org
Subject: Re: [Xenomai] what limits number of pSOS tasks using t_create?

On 05/13/2016 03:27 PM, Marcel Van Mierlo wrote:
> Hi,
>
>
> Which parameters limit the number of psos skin tasks that can be created =
using t_create()? (ARM (Beagle), Xenomai 3.0).
>
> At the moment I am getting ERR_NOTCB back after creating about 118 tasks =
(just calling t_create not t_start). In production we are hitting the limit=
 at about 70 tasks...though sometimes we can go a bit higher.
>
>>From the documentation I see:
>
> * t_create() returns ERR_NOTCB upon memory allocation failure when
> trying to get a task control block from the nucleus heap. There is
> no control block limit for tasks.
>
>
> So I adjusted the following:
>
> CONFIG_XENO_OPT_SYS_HEAPSZ=3D1024
> CONFIG_XENO_OPT_PRIVATE_HEAPSZ=3D128
> CONFIG_XENO_OPT_SHARED_HEAPSZ=3D128
>

You likely need to raise CONFIG_XENO_OPT_REGISTRY_NRSLOTS.

--
Philippe.

