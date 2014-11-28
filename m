From: =?iso-8859-1?Q?Terje_Fr=F8ysa?= <Terje.Froysa@sintef.no>
Date: Fri, 28 Nov 2014 18:00:27 +0000
Message-ID: <314E5ECDAA86314791309FA670550F89C9C4C7FA@SINTEFEXMBX05.sintef.no>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Method for measuring CPU idle time in Xenomai?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Sirs,

I have now four real time processes running and a mix of rt-tasks and Linux=
 tasks.
In a pure Linux environment, CPU idle time can be estimated by:

awk '{print ($2*100)/$1 " % idle over "$1/60 " min"}' /proc/uptime

Question:
Will this method apply in an Xenomai environment too?
If not, is there any method that will apply?

Best regards
Terje Froysa

Smail: Terje Fr=F8ysa, SINTEF ICT (Information and Communication Technology=
), N-7465 Trondheim, Norway.
Email: terje.froysa@sintef.no<blocked::mailto:terje.froysa@sintef.no> <mail=
to:terje.froysa@sintef.no<blocked::mailto:terje.froysa@sintef.no>>
Phone: +47 930 03603
Company: Independent R&D, see <http://www.sintef.no/<blocked::http://www.si=
ntef.no/>

