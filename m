Message-ID: <52F4E7A4.4030701@xenomai.org>
Date: Fri, 07 Feb 2014 15:03:16 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <52F3B77F.3020405@marel.com> <52F3C5DD.8010208@xenomai.org>
 <52F3DBDB.4060805@xenomai.org> <52F49F07.9040801@xenomai.org>
 <52F4E084.3020809@marel.com>
In-Reply-To: <52F4E084.3020809@marel.com>
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
To: Marcel van Mierlo <marcel.vanmierlo@marel.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 02/07/2014 02:32 PM, Marcel van Mierlo wrote:

> - Why is printf/fflush impacting time taken to invoke q_send?
>

Depending on how you measure this, but since printf/fflush will turn 
your thread to secondary mode, qsend() won't be charged for the same 
transition it (unexpectedly) requires since your thread will be in that 
mode already.

-- 
Philippe.

