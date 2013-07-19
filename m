From: Skander Bahloul <skander.bahloul@imag.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jul 2013 11:17:42 +0200
Message-Id: <C83BFA2D-B71C-4494-B6F8-931A2F0EE44E@imag.fr>
Mime-Version: 1.0 (Apple Message framework v1085)
Subject: [Xenomai] shielding fully CPU or CORE
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear Xenomai list members,

On a successful instal (but without NVIDIA driver, cf my previous =
message), I am now starting using Xenomai.

We need to :
1* shield fully a CPU or core, against the scheduler, interruption, etc
2* run a single thread on this isolated CPU or core

Step 2 is OK with the Xenomai API.
But how should I achieve step 1 ?

I did not find advice in the Xenomai documentation.
I guess it should be done with :
	$ sudo shield -a 0-3 -m -1

Do you agree ?
When may I find detailed info on CPU shielding ?

Thanks,
Skander BAHLOUL



