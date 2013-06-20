Message-ID: <1371694084.22285.YahooMailNeo@web161401.mail.bf1.yahoo.com>
Date: Wed, 19 Jun 2013 19:08:04 -0700 (PDT)
From: Tom Z <tomz30@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] alarms on multi-core systems
Reply-To: Tom Z <tomz30@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,=0ASuppose I have two tasks bound to two cores, say CPU_0 and CPU_1, and=
 each of them has an alarm (or timer), can I guarantee that both alarms are=
 synchronized, say, they expire at the same time based on the same world cl=
ock? Or, does Xenomai utilize a global clock for all cores, which can be fo=
und in some modern multi-core architectures, to implement alarms?=0A=0AThan=
ks,=0ATom=0A
