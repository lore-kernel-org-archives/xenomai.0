From: Johannes Holtz <johannes.holtz@compador.de>
Subject: RTnet bind failed socket again
Message-ID: <ea8b5153-3530-4b7b-3a73-586cda346cbe@compador.de>
Date: Mon, 3 Jun 2019 11:06:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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

My program opens a RTnet socket successfully but the program gets killed 
by a different issue that has nothing to do with this. However, the 
RTnet socket is still bound. If I try to start the program again i get 
the error "Address already in use". If it would be a normal unix socket 
I would simply call it with SO_REUSEADDR but this is not possible with 
RTnet from what I understand.
My question is why the socket is not unbound after the binding process 
is killed and if there is a way to reclaim this socket. By the way, it 
has to be this socket since the communication partner expects the server 
to listen on this exact port.

Cheers,

Johannes



