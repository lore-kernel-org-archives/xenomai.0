Message-ID: <b647ffbd0603140523x11dfc345n@domain.hid>
Date: Tue, 14 Mar 2006 15:23:04 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] interrupt wait problem
In-Reply-To: <44168DA0.3090506@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <44168DA0.3090506@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: marcellin <marcellin.fotze@domain.hid>
Cc: xenomai@xenomai.org

On 14/03/06, marcellin <marcellin.fotze@domain.hid> wrote:

>
> //in the irq task
>
>
> err =3D rt_intr_wait( &intr_desc,TIMEOUT );
>                      if(err){
>            printf("AcqProcess -> failed to wait interrupt :
> %s",strerror(-err));
>        }

On success, rt_intr_wait() returns a positive value equal to a number
of currently pending interrupts and not 0.

Although, I don't know how e.g. 1 would be interpreted as "an
operation not permited" with strerror(). strerror(-1) should have
given an "unknown error" or smth like this.

Anyway, please take a look at what exactly the return value is :
negative or positive.


>
> regards
>
> Marcell1

--
Best regards,
Dmitry Adamushko

