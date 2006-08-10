Message-ID: <b647ffbd0608100759k44c1d05dk15868fb2e09966ab@domain.hid>
Date: Thu, 10 Aug 2006 16:59:38 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] -EINTR using rt_pipe_read with TM_INFINITE
In-Reply-To: <46942.127.0.0.1.1155228223.squirrel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_29185_28650977.1155221978216"
References: <58356.127.0.0.1.1155128979.squirrel@domain.hid>
	<44DA6D99.9090502@domain.hid>
	<46942.127.0.0.1.1155228223.squirrel@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jacques GANGLOFF <jacques@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

------=_Part_29185_28650977.1155221978216
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

take a look at the 4-th parameter of rt_pipe_create() :

@param poolsize Specifies the size of a dedicated buffer pool for the
 * pipe. Passing 0 means that all message allocations for this pipe are
 * performed on the system heap.

The system heap is also used for other allocations and not only to serve a
given heap. It's default size is 128 Kb (configurable through the config
though).

Passing non-zero parameter causes a private heap of the given size to be
created for this heap.

Note, it's a size in bytes, not a flag (in your example you use 1 for the
second heap).

This value is rounded up to a page size.

rt_pipe_create()
{
...
if (poolsize < 2 * PAGE_SIZE)
                        poolsize = 2 * PAGE_SIZE;

poolsize = xnheap_rounded_size(poolsize, PAGE_SIZE);



-- 
Best regards,
Dmitry Adamushko

------=_Part_29185_28650977.1155221978216
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>
Hello,<br>
<br>
take a look at the 4-th parameter of rt_pipe_create() :<br>
<br>
@param poolsize Specifies the size of a dedicated buffer pool for the<br>
&nbsp;* pipe. Passing 0 means that all message allocations for this pipe are<br>
&nbsp;* performed on the system heap.<br clear="all"><br>
The system heap is also used for other allocations and not only to
serve a given heap. It's default size is 128 Kb (configurable through
the config though).<br>
<br>
Passing non-zero parameter causes a private heap of the given size to be created for this heap.<br>
<br>
Note, it's a size in bytes, not a flag (in your example you use 1 for the second heap). <br>
<br>
This value is rounded up to a page size.<br>
<br>
rt_pipe_create()<br>
{<br>
...<br>
if (poolsize &lt; 2 * PAGE_SIZE)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
poolsize = 2 * PAGE_SIZE;<br>
<br>
 poolsize = xnheap_rounded_size(poolsize, PAGE_SIZE);<br>
<br>
<br>
<br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_29185_28650977.1155221978216--

