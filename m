Message-ID: <52E51CAD.6030705@xenomai.org>
Date: Sun, 26 Jan 2014 15:33:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtcbBAPx8XgPQiZtWqwN=MERqRL7AfyKqPnTyB1yfigqKQ@mail.gmail.com>
In-Reply-To: <CAKKWdtcbBAPx8XgPQiZtWqwN=MERqRL7AfyKqPnTyB1yfigqKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai kernel task in Domain 1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 01/26/2014 07:31 AM, ali hagigat wrote:
> How can i make a Xenomai kernel task switch to the secondary domain?

You can not. Kernel-space tasks only run in Xenomai domain.

-- 
                                                                Gilles.

