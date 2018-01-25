References: <1516887803.30016.10.camel@sprinte.eu>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e707e0e2-a55b-5ac4-f97c-b57882b36eaf@xenomai.org>
Date: Thu, 25 Jan 2018 15:21:03 +0100
MIME-Version: 1.0
In-Reply-To: <1516887803.30016.10.camel@sprinte.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Posix vs Alchemy - multiplexing and registry
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Julien Blanc <julien.blanc@sprinte.eu>, xenomai@xenomai.org

On 01/25/2018 02:43 PM, Julien Blanc wrote:
> Hi,
> 
> We have a xenomai 3 application currently using the alchemy API
> (application development started on xenomai 2.x).
> 
> We would like to add I/O multiplexing in some parts of the application.
> My understanding is that it is not supported by the alchemy API, so we
> would have to resort to the Posix API.
> 
> The downside is that by doing so, we lose the registry : with the posix
> api nothing is exported. We would like to access all this data, at
> least for debugging purposes (ideally, disable it in production build).
> 
> I couldnt find any pointer for doing either of the following :
> - enable the registry while using the posix API
> - multiplex using the alchemy api
> - retrieve a posix-api compatible file descriptor from an alchemy
> handle (which would allow a __cobalt_select call)
> 
> Is there some resources or something obvious that i'm missing ?
> 

There is no provision for I/O multiplexing with alchemy. Only the pipe
object embeds a RTDM file descriptor which could be passed to
libcobalt's select() implementation, other resources (e.g. queues,
buffers etc) don't.

I would suggest to enable the registry for your application (not for the
entire POSIX API), as you might not need each and every resource to be
exposed via a fuse-based fs.

To do so, you can link against libcopperplate, which is not documented.
However, looking at lib/alchemy/init.c may give you some hints about the
way to create your own registry hierarchy (see alchemy_init()). Then
looking at sections defined for CONFIG_XENO_REGISTRY in e.g. queue.c
would give you an illustration of a proper client-side usage, for
populating this hierarchy with object nodes, and the way to return
information back when those nodes are opened for reading.

-- 
Philippe.

