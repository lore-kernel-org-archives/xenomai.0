Message-ID: <52D3DE54.30608@xenomai.org>
Date: Mon, 13 Jan 2014 13:38:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52CEA753.8000800@espera.de>
In-Reply-To: <52CEA753.8000800@espera.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] POSIX message queues
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: schwark@espera.de
Cc: xenomai@xenomai.org

On 01/09/2014 02:42 PM, Andreas Schwark wrote:
> Hi all,
> 
> we are working with Orocos-Toolchain on a PC with Lubuntu Version 12.04 
> patched with Xenomai. For inter-process communication between Orocos 
> processes we use POSIX messages queues. The communication works fine 
> with less then 60 message queues. If we want to use more than 60 message 
> quess, than we are not able to create more than 60 queues.

Have you checked mq_open documentation for the error you get?


-- 
                                                                Gilles.

