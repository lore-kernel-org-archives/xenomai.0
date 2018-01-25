Message-ID: <1516887803.30016.10.camel@sprinte.eu>
From: Julien Blanc <julien.blanc@sprinte.eu>
Date: Thu, 25 Jan 2018 14:43:23 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Posix vs Alchemy - multiplexing and registry
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

We have a xenomai 3 application currently using the alchemy API
(application development started on xenomai 2.x).

We would like to add I/O multiplexing in some parts of the application.
My understanding is that it is not supported by the alchemy API, so we
would have to resort to the Posix API.

The downside is that by doing so, we lose the registry : with the posix
api nothing is exported. We would like to access all this data, at
least for debugging purposes (ideally, disable it in production build).

I couldnt find any pointer for doing either of the following :
- enable the registry while using the posix API
- multiplex using the alchemy api
- retrieve a posix-api compatible file descriptor from an alchemy
handle (which would allow a __cobalt_select call)

Is there some resources or something obvious that i'm missing ?

Best regards,

Julien



