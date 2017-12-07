References: <48bfcc92-3224-c7ce-10d9-9f4621e10331@tuebingen.mpg.de>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <d009beb3-49d6-b318-e872-51ce93e49cf2@xenomai.org>
Date: Thu, 7 Dec 2017 10:46:51 +0100
MIME-Version: 1.0
In-Reply-To: <48bfcc92-3224-c7ce-10d9-9f4621e10331@tuebingen.mpg.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Xenomai 3.0.5 : RTIPC/XDDP protocol not supported by
 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Vincent Berenz <vberenz@tuebingen.mpg.de>, xenomai@xenomai.org

On 12/06/2017 10:55 AM, Vincent Berenz wrote:
> Hi,
> 
> We are currently moving from xenomai 2 to xenomai 3.
> I installed xenomai 3.0.5, and all seems to be working, with low latency.
> 
> I am now trying to get our legacy code to work on xenomai 3 using the
> transition kit.
> 
> Our program compiles, but at runtime, on call to rt_pipe_create :
>         0"000.000| WARNING: [main] RTIPC/XDDP protocol not supported by
> kernel
> 

Do you observe the same issue with any of the native POSIX demo apps
available from <xenomai-install>/demo/xddp-*?

-- 
Philippe.

