References: <1517561505.2571.7.camel@sprinte.eu>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b7dd0f59-098c-25b4-46e8-ca60250c01cd@xenomai.org>
Date: Sun, 4 Feb 2018 10:58:48 +0100
MIME-Version: 1.0
In-Reply-To: <1517561505.2571.7.camel@sprinte.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Multiplexing and rtcan socket
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Julien Blanc <julien.blanc@sprinte.eu>, xenomai@xenomai.org

On 02/02/2018 09:51 AM, Julien Blanc wrote:
> I'm trying to use multiplexing wih rtcan sockets (using
> xeno_can_flexcan driver).
> 
> Unfortunately, i had no luck yet to make it work. __RT(select) fails
> with ENODEV error, while __RT(poll) returns a POLLERR event.

poll() is not implemented by libcobalt, only select() so far, so I would 
be surprised that __RT(poll()) had ever been called. The regular poll() 
service from the glibc may have been.

> 
> Is it unsupported, or am i doing something wrong ? (like a missing
> parameter). Sample code to reproduce the issue is attached.
> 

The RTCAN stack predates the implementation of select(), and was never 
updated to provide this, hence ENODEV. If somebody volunteers to provide 
this, this should likely go into the code implementing the raw CAN socket.

-- 
Philippe.

