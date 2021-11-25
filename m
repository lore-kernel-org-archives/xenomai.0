Subject: Re: [PATCH 1/6] drivers/can: add multi message support to sendmsg
References: <20211124234648.7428-1-dariobin@libero.it>
 <20211125004644.1.Ib16491ef1950ca5ad44805af98a594a9e0622729@changeid>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fa1059c4-3ee9-64d4-5884-737489404827@siemens.com>
Date: Thu, 25 Nov 2021 11:26:34 +0100
MIME-Version: 1.0
In-Reply-To: <20211125004644.1.Ib16491ef1950ca5ad44805af98a594a9e0622729@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dario Binacchi <dariobin@libero.it>, xenomai@xenomai.org
Cc: Philippe Gerum <rpm@xenomai.org>, Socketcan-users@lists.berlios.de, Michael Trimarchi <michael@amarulasolutions.com>, Gianluca Falavigna <gianluca.falavigna@inwind.it>, Wolfgang Grandegger <wg@grandegger.com>, "Stephen J . Battazzo" <stephen.j.battazzo@nasa.gov>, Sebastian.Smolorz@stud.uni-hannover.de

On 25.11.21 00:46, Dario Binacchi wrote:
> The `user_msghdr' structure is designed to send multiple messages as
> well, so rtcan_raw_sendmsg() can also send multiple messages. This
> avoids having to add the sendmmsg system call which requires more
> extensive Xenomai changes.
> 
> Signed-off-by: Dario Binacchi <dariobin@libero.it>
> ---
> 
>  kernel/drivers/can/rtcan_raw.c | 239 ++++++++++++++++++---------------
>  1 file changed, 128 insertions(+), 111 deletions(-)
> 

Thanks for your contribution!

rtcan is currently not covered by our testsuite. Before touching this
generic code, I would like to use the chance and add a simple can-virt
testcase to smokey (analogously to the rtnet test) so that this change
is covered as well.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

