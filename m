Message-ID: <47178DFA.5040703@domain.hid>
Date: Thu, 18 Oct 2007 18:46:50 +0200
From: Pierangelo Masarati <masarati@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Latest x86_64 seems to require a fix
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Dear ADEOS users,

it seems that a "local_irq_disable_hw();" is required before "return 1;"
in __ipipe_syscall_root() in the latest patches (e.g. the 1.2 series),
otherwise user-space applications could fail badly.

Sincerely, p.




