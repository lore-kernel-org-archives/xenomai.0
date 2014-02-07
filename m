Message-ID: <52F4F768.2060808@xenomai.org>
Date: Fri, 07 Feb 2014 16:10:32 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52F3B77F.3020405@marel.com> <52F3C5DD.8010208@xenomai.org>
 <52F3DBDB.4060805@xenomai.org> <52F49F07.9040801@xenomai.org>
 <52F4E084.3020809@marel.com> <52F4E865.5000200@xenomai.org>
 <52F4EE97.2070800@marel.com> <52F4EFE5.2040000@xenomai.org>
 <52F4F698.7030900@marel.com>
In-Reply-To: <52F4F698.7030900@marel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] High CPU load using q_send under pSOS skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marcel van Mierlo <marcel.vanmierlo@marel.com>
Cc: xenomai@xenomai.org

On 02/07/2014 04:07 PM, Marcel van Mierlo wrote:
> TASK cio_watchdog_kick(void)
> {
>       u_long cantmsg[4];

This one should be properly aligned, what about the buffer you use for 
q_recv?


-- 
					    Gilles.

