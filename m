Date: Mon, 23 Jul 2018 10:05:37 +0200
From: =?utf-8?q?Petr_=C4=8Cervenka?= <grugh@centrum.cz>
MIME-Version: 1.0
Message-Id: <20180723100537.30189BBB@centrum.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] =?utf-8?q?CONFIG=5FMAXSMP_prevents_booting?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hello.
I have tried newest Kubuntu 18.04 LTS with Xenomai 3.0.7 (cobalt) and 4.9.90 kernel (with appropriate ipipe patch).
I was not able too boot the new patched kernel and the solution took me many hours of searching and trials and errors. Finally I found a message from Antoine Hoarau (my thanks) about the CONFIG_MAXSMP in the mailing list. It was enabled in the default configuration of Kubuntu 18.04. Once I disabled it, everything was fine.
Please, can you make some notice about it, for example in the Troubleshooting wiki of the Xenomai? I would speed up the finding of the solution greatly.
Thanks in advance.
Petr Cervenka
 

