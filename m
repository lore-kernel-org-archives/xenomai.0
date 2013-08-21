From: Younes CHALABI <y.chalabi@sinters.fr>
Date: Wed, 21 Aug 2013 08:42:13 +0000
Message-ID: <A46EF8CF1BBB8E4B8A27B73E177C4664033F8725@MAIL-SINTERS-01.sinters-int.fr>
References: <C04BB818-2870-47BC-879F-1588F55C8303@imag.fr>
In-Reply-To: <C04BB818-2870-47BC-879F-1588F55C8303@imag.fr>
Content-Language: fr-FR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] RE :  test latency : negative value
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Skander Bahloul <skander.bahloul@imag.fr>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Skander,

Yes it's normal to have negative values. To resolve it you have to calibrat=
e your system.

To do this, strat by putting 0 value on latency : echo 0 > /proc/xenomai/la=
tency

Then execute the test : latency -p100 -T1800 for example.=20

Once the test finished, you may have the minimum value of latency.

Now put it on latency : echo #min-latency-val > /proc/xenomai/latency

And retry the test show before. You sould not have any more negative values=
.=20

Best regards,

Younes CHALABI
________________________________________
De : xenomai-bounces@xenomai.org [xenomai-bounces@xenomai.org] de la part d=
e Skander Bahloul [skander.bahloul@imag.fr]
Date d'envoi : mercredi 21 ao=FBt 2013 10:35
=C0 : xenomai@xenomai.org
Objet : [Xenomai] test latency : negative value

Hi Dear Xenomai mailing list,

I'm using the latency test of Xenomai and sometimes i find negative values =
of latency time.

Is it  normal to have negative values of latency time?

if no, what's the problem?


Thank you very for help me to understand this issue.

Best regards,
_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
http://www.xenomai.org/mailman/listinfo/xenomai

