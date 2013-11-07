Message-ID: <527BD591.9060504@xenomai.org>
Date: Thu, 07 Nov 2013 19:01:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <527B5BBF.2040301@siemens.com>
In-Reply-To: <527B5BBF.2040301@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-forge] [PATCH] Silence unused_result warning
 from write()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gernot Hillier <gernot.hillier@siemens.com>
Cc: xenomai@xenomai.org

On 11/07/2013 10:22 AM, Gernot Hillier wrote:
> Some glibc versions mark write() with attribute warn_unused_result (found in
> Ubuntu 12.04 / eglibc 2.15 / gcc 4.6.3), so we need to silence this warning,
> especially when building with -Werror.

Why not casting write result to void, it does not work?

-- 
                                                                Gilles.

