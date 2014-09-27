Message-ID: <5426DE0A.6070802@xenomai.org>
Date: Sat, 27 Sep 2014 17:55:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CABVE6k2Cwx00+g5zTbSqZHTJOqOT6XRPr98KFjOzjpZU=jHW7g@mail.gmail.com>
In-Reply-To: <CABVE6k2Cwx00+g5zTbSqZHTJOqOT6XRPr98KFjOzjpZU=jHW7g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Xenomai: /dev/rtheap is missing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?SGFzcmV0IFNhcsSxeWVy?= <hsrtsryr@gmail.com>, Xenomai@xenomai.org

On 09/27/2014 03:01 PM, Hasret Sarıyer wrote:
> I want to run small code with xenomai. I used this page to  compile kernel
> and install xenomai.
> 
> http://www.stanley.gatech.edu/skelly/uncategorized/installing-xenomai-on-ubuntu-12-04/#comment-3379
> 
> I didn't change configuration options.When I run "sudo
> ./trivial-periodic",the output is Xenomai: /dev/rtheap is missing
> (chardev, major=10 minor=254).
> 
> In this question, xenomai 2.6.0 was recommended -> .
> http://www.xenomai.org/pipermail/xenomai/2011-October/024664.html

Please:
- use the latest stable version, that is Xenomai 2.6.4
- follow the installation instructions here:
http://xenomai.org/2014/06/building-debian-packages/


-- 
                                                                Gilles.

