Date: Mon, 3 Jun 2019 04:10:44 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <1523560934.2012965.1559553044281.JavaMail.zimbra@wolfram.com>
In-Reply-To: <ea8b5153-3530-4b7b-3a73-586cda346cbe@compador.de>
References: <ea8b5153-3530-4b7b-3a73-586cda346cbe@compador.de>
Subject: Re: RTnet bind failed socket again
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Johannes Holtz <johannes.holtz@compador.de>
Cc: xenomai <xenomai@xenomai.org>




----- Den 3 jun 2019, p=C3=A5 kl 11:06, xenomai xenomai@xenomai.org skrev:

> Hi,

> My program opens a RTnet socket successfully but the program gets killed
> by a different issue that has nothing to do with this. However, the
> RTnet socket is still bound. If I try to start the program again i get
> the error "Address already in use". If it would be a normal unix socket
> I would simply call it with SO_REUSEADDR but this is not possible with
> RTnet from what I understand.

I tried this and failed miserably. That said, I'm also interested in the an=
swer to this question.=20

> My question is why the socket is not unbound after the binding process
> is killed and if there is a way to reclaim this socket. By the way, it
> has to be this socket since the communication partner expects the server
> to listen on this exact port.

> Cheers,

> Johannes

Per =C3=96berg=20

