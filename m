Date: Thu, 19 Apr 2018 15:27:04 +0200 (CEST)
From: Yann le Chevoir <yann.le-chevoir@etu.esisar.grenoble-inp.fr>
Message-ID: <2015698043.3051149.1524144424600.JavaMail.zimbra@etu.esisar.grenoble-inp.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Call Alchemy API from a Posix skin thread
Reply-To: Yann le Chevoir <yann.le-chevoir@grenoble-inp.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hello,

With Xenomai 3, I understood that all skins are based on Posix skin,
right?

I used to use Posix skin.
I have a third party Alchemy API (I am wondering if it was well ported
from Native to Alchemy or not...).

Why can not I call this API from my Posix skin? Is it an expected
behavior?
Given an example, I have an EPERM error when the third party API calls
a rt_mutex_acquire from my Posix (Xenomai) thread.

I thought that both Alchemy and Posix skins would create a "Xenomai thread"
and so I could mix the calls to API skins.
If not, I can understand too...

Thank you for letting me know about this.
Perhaps I just have to call an Alchemy Init function from my Posix thread?
It could be a solution.

Regards,

Yann

