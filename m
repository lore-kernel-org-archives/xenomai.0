MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Message-ID: <17992.46476.24771.264671@domain.hid>
Date: Mon, 14 May 2007 21:16:28 +0200
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7A4AB0C9@domain.hid>
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0C9@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Content-Transfer-Encoding: Quoted-Printable
Subject: Re: [Xenomai-help] Problem with Message queue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org

Fillod Stephane wrote:
 > Perrine Martignoni wrote:
 > [..]
 > >int DESTRUCT=3D0;
 > =A0
 > I'm always nervous to see global variables shared among threads withou=
t
 > a volatile keyword. An explicit memory barrier would be better, as it
 > has been re-explained in a LWN article lately (wait Thursday for free =
access)
 > http://lwn.net/Articles/233479/

Besides, this termination mechanism results on a deadlock on SMP. Please
kill this DESTRUCT variable and replace cleanup_upon_sig with:

void cleanup_upon_sig(int sig __attribute__((unused)))

{
	pthread_cancel(task1);
	pthread_cancel(task2);
}


--=20


					    Gilles Chanteperdrix.

