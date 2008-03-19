Message-ID: <2ff1a98a0803190613r7572d87eibef16aecf39ef71a@domain.hid>
Date: Wed, 19 Mar 2008 14:13:50 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <6621.81.252.86.91.1205927700.squirrel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <16201.81.252.86.91.1205764989.squirrel@domain.hid>
	<18400.53752.538963.384358@domain.hid>
	<6621.81.252.86.91.1205927700.squirrel@domain.hid>
Subject: Re: [Xenomai-help] Application crash
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabien MAHOT <fabien.mahot@domain.hid>
Cc: xenomai@xenomai.org

On Wed, Mar 19, 2008 at 12:55 PM, Fabien MAHOT
<fabien.mahot@domain.hid> wrote:
> > Except the fact that your program relies on correct priorities ordering
>  > for starting up tasks, which does not always work if priority coupling is
>  > disabled, your program runs just fine on ARM.
>  >
>  > On what platform are you testing this program ? What does
>  > getconf GNU_LIBPTHREAD_VERSION
>  > returns on your platform ?
>  > Could you send me the .config of the kernel you are using ?
>
>  Thanks for your answers,
>
>  My platform is Geode AMD Processor i586.
>  (I use Adeos-ipipe-2.6.23-i386-1.12-03 patch of Xenomai-2.4.2)
>
>  getconf GNU_LIBPTHREAD_VERSION returns NPTL 2.5
>
>  And , there is the .config of my kernel in attached files.

Are you sure this is the right .config ? I see that priority coupling
is enabled.


-- 
 Gilles

