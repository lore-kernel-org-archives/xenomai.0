Message-ID: <1521024178.8992.7.camel@sprinte.eu>
From: Julien Blanc <julien.blanc@sprinte.eu>
Date: Wed, 14 Mar 2018 11:42:58 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Strange behaviour after calling clock_settime
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

The current xenomai documentation states that it is allowed to call
clock_settime with CLOCK_REALTIME parameter to set the value of the
xenomai realtime clock. On our board, the value at bootup is always 0
(so, epoch), despite the hardware clock being correctly set.

However, we experience bad behaviour when doing so. Notably, alchemy
condition variables seems to no longer work. Resetting the xenomai
CLOCK_REALTIME to the initial value puts things back in order.

Is it a known issue ? Are we doing something wrong ? Or is it just
better to let the xenomai CLOCK_REALTIME live its life, considering it
as a CLOCK_MONOTONIC, and rely to CLOCK_HOST_REALTIME whenever we need
real dates ?

Regards

Julien

