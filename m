Message-ID: <4625E977.9040201@domain.hid>
Date: Wed, 18 Apr 2007 11:48:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <403B28AE6257B548B66BB88414AC78330174BBD6@domain.hid>
In-Reply-To: <403B28AE6257B548B66BB88414AC78330174BBD6@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: Quoted-Printable
Subject: Re: [Adeos-main] AT91SAM9261 adeos support for 2.6.19 kernel
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: BOUIN Alexandre <abouin@domain.hid>
Cc: adeos-main@gna.org

BOUIN Alexandre wrote:
> Nouveaux r=E9sultats, nouvelle =E9bauche de mail :
> "
> 11 hours later ... here are our results on AT91SAM9261-EK board, and ou=
r Adeos patch.
>=20
> [run test]
> uclibc login: root
> # cd /usr/xenomai/bin/
> # ./latency -p 500 -h
> [results]
> HSH|--param|--samples-|--average--|---stddev--
> HSS|    min|     38253|     17.897|      1.879
> HSS|    avg|  76507896|     39.422|     16.059
> HSS|    max|     38253|     65.688|      6.736
> ---|------------|------------|------------|--------|-------------------=
------
> RTS|       9.023|      39.798|      94.420|       0|    10:37:32/10:37:=
32
>=20
> There was no load while performing these tests. So Gilles, if you had m=
ade some softs to make some load, we'll be glad to know them.

Please read the TROUBLESHOOTING file.

--=20
                                                 Gilles Chanteperdrix

