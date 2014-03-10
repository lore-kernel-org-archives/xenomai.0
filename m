Message-ID: <531DD795.5050801@xenomai.org>
Date: Mon, 10 Mar 2014 16:17:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtdSNQ1BHnqfOQjQcXHVAztzqkCu2qd60DOVwvtYJxcx+Q@mail.gmail.com>
In-Reply-To: <CAKKWdtdSNQ1BHnqfOQjQcXHVAztzqkCu2qd60DOVwvtYJxcx+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] a question about rt_mutex_acquire()
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

On 03/10/2014 04:01 PM, ali hagigat wrote:
> rt_mutex_acquire() creates a segmentation fault, why?

Because rt_mutex_create failed? Otherwise we would see the message 
"success"?

Is this a game? Or are you using Xenomai for a real project?


-- 
					    Gilles.

