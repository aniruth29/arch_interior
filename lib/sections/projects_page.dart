import 'dart:ui';

import 'package:flutter/material.dart';
import '../home_page.dart';

class ClientProject {
  final String name;
  final String thumbnail;
  final List<String> galleryImages;
  final String hoverEffect; // New field to specify hover effect

  ClientProject({
    required this.name,
    required this.thumbnail,
    required this.galleryImages,
    this.hoverEffect = 'scale', // Default effect
  });
}

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});
  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  // Map to assign different hover effects to different projects
  final Map<String, String> _projectHoverEffects = {
    'Avinash': 'scale',
    'Kilpauk': 'wipe_left',
    'Lake Dugar': 'slide_right_left',
    'Medavakam': 'rotate',
    'Brakes India Bawal': 'scale',
    'Chetpet Office': 'slide_right_left',
    'Egmore Showroom': 'reveal_right',
    'Muppad Assembly': 'scale',
    'OP Mobility Canteen': 'rotate',
    'OP Mobility Display': 'slide_down_up',
    'Universal': 'scale',
    'TIDC': 'reveal_left',
  };

  final List<ClientProject> residentialClients = [
    ClientProject(
      name: 'Avinash',
      thumbnail: 'assets/residential/1_avi.jpeg',
      galleryImages: [
        'assets/project_page/Residential Project/Avinash/1_avi.jpeg',
        'assets/project_page/Residential Project/Avinash/2_avi_p.jpeg',
        'assets/project_page/Residential Project/Avinash/3_avi.jpeg',
        'assets/project_page/Residential Project/Avinash/4_avi.jpeg',
        'assets/project_page/Residential Project/Avinash/5_avi_tv.jpeg',
        'assets/project_page/Residential Project/Avinash/6_avi_fc.jpeg',
        'assets/project_page/Residential Project/Avinash/7_avi.jpeg',
        'assets/project_page/Residential Project/Avinash/8_avi.jpeg',
        'assets/project_page/Residential Project/Avinash/9_avi_k.jpeg',
        'assets/project_page/Residential Project/Avinash/10_avi_k.jpeg',
        'assets/project_page/Residential Project/Avinash/11_avi_k.jpeg',
        'assets/project_page/Residential Project/Avinash/12_avi_k.jpeg',
        'assets/project_page/Residential Project/Avinash/13_avi_po.jpeg',
        'assets/project_page/Residential Project/Avinash/14_avipo.jpeg',
        'assets/project_page/Residential Project/Avinash/15_avi.jpeg',
        'assets/project_page/Residential Project/Avinash/16_avi_w.jpeg',
        'assets/project_page/Residential Project/Avinash/17_avi_fc.jpeg',
        'assets/project_page/Residential Project/Avinash/18_avi.jpeg',
        'assets/project_page/Residential Project/Avinash/19_avi_w.jpeg',
        'assets/project_page/Residential Project/Avinash/20_avi_w.jpeg',
        'assets/project_page/Residential Project/Avinash/21_avi_fc.jpeg',
        'assets/project_page/Residential Project/Avinash/22_avi_rr.jpeg',
        'assets/project_page/Residential Project/Avinash/23_avi.jpeg',
        'assets/project_page/Residential Project/Avinash/24_avi_s.jpeg',
        'assets/project_page/Residential Project/Avinash/25_avi_w.jpeg',
        'assets/project_page/Residential Project/Avinash/26_avi_rr.jpeg',
        'assets/project_page/Residential Project/Avinash/27_avi_w.jpeg',
        'assets/project_page/Residential Project/Avinash/28_avi.jpeg',
        'assets/project_page/Residential Project/Avinash/29_avi_rr.jpeg',
        'assets/project_page/Residential Project/Avinash/30_avi.jpeg',
        'assets/project_page/Residential Project/Avinash/31_avi.jpeg',
      ],
    ),
    ClientProject(
      name: 'Kilpauk',
      thumbnail: 'assets/project_page/Residential Project/Kilpauk/1_k.webp',
      galleryImages: [
        'assets/project_page/Residential Project/Kilpauk/2_k_tv.webp',
        'assets/project_page/Residential Project/Kilpauk/3_k_w_p_po.webp',
        'assets/project_page/Residential Project/Kilpauk/4_k.webp',
        'assets/project_page/Residential Project/Kilpauk/5_k.webp',
        'assets/project_page/Residential Project/Kilpauk/6_k.webp',
        'assets/project_page/Residential Project/Kilpauk/7_k_w.webp',
        'assets/project_page/Residential Project/Kilpauk/8_k.webp',
        'assets/project_page/Residential Project/Kilpauk/9_k.webp',
        'assets/project_page/Residential Project/Kilpauk/10_k.webp',
        'assets/project_page/Residential Project/Kilpauk/11_k.webp',
        'assets/project_page/Residential Project/Kilpauk/12_k_w.webp',
        'assets/project_page/Residential Project/Kilpauk/13_k_w.webp',
        'assets/project_page/Residential Project/Kilpauk/14_k.webp',
      ],
    ),
    ClientProject(
      name: 'Lake Dugar',
      thumbnail: 'assets/project_page/Residential Project/Lake Dugar/15_ldr_s.webp',
      galleryImages: [
        'assets/project_page/Residential Project/Lake Dugar/1_ldr.webp',
        'assets/project_page/Residential Project/Lake Dugar/2_ldr.webp',
        'assets/project_page/Residential Project/Lake Dugar/3_ldr.webp',
        'assets/project_page/Residential Project/Lake Dugar/4_ldr.webp',
        'assets/project_page/Residential Project/Lake Dugar/5_ldr_tv.webp',
        'assets/project_page/Residential Project/Lake Dugar/6_ldr.webp',
        'assets/project_page/Residential Project/Lake Dugar/7_ldr_p.webp',
        'assets/project_page/Residential Project/Lake Dugar/8_ldr_k.webp',
        'assets/project_page/Residential Project/Lake Dugar/9_ldr_k.webp',
        'assets/project_page/Residential Project/Lake Dugar/10_ldr_k.webp',
        'assets/project_page/Residential Project/Lake Dugar/11_ldr_fc.webp',
        'assets/project_page/Residential Project/Lake Dugar/12_ldr_w.webp',
        'assets/project_page/Residential Project/Lake Dugar/13_ldr_s.webp',
        'assets/project_page/Residential Project/Lake Dugar/14_ldr.webp',
        'assets/project_page/Residential Project/Lake Dugar/15_ldr_s.webp',
        'assets/project_page/Residential Project/Lake Dugar/16_ldr_w.webp',
        'assets/project_page/Residential Project/Lake Dugar/17_ldr_w_s.webp',
        'assets/project_page/Residential Project/Lake Dugar/18_ldr_fc.webp',
        'assets/project_page/Residential Project/Lake Dugar/19_ldr.webp',
        'assets/project_page/Residential Project/Lake Dugar/20_ldr.webp',
      ],
    ),
    ClientProject(
      name: 'Medavakam',
      thumbnail: 'assets/project_page/Residential Project/Medavakam/1_m.webp',
      galleryImages: [
        'assets/project_page/Residential Project/Medavakam/1_m.webp',
        'assets/project_page/Residential Project/Medavakam/2_m.webp',
        'assets/project_page/Residential Project/Medavakam/3_m.webp',
        'assets/project_page/Residential Project/Medavakam/4_m.webp',
        'assets/project_page/Residential Project/Medavakam/5_m_tv.webp',
        'assets/project_page/Residential Project/Medavakam/6_m.webp',
        'assets/project_page/Residential Project/Medavakam/7_m_p.webp',
        'assets/project_page/Residential Project/Medavakam/8_m_fc.webp',
        'assets/project_page/Residential Project/Medavakam/9_m.webp',
        'assets/project_page/Residential Project/Medavakam/10_m_k.webp',
        'assets/project_page/Residential Project/Medavakam/11_m_k.webp',
        'assets/project_page/Residential Project/Medavakam/12_m_k.webp',
        'assets/project_page/Residential Project/Medavakam/13_m_fc.webp',
        'assets/project_page/Residential Project/Medavakam/14_m_po.webp',
        'assets/project_page/Residential Project/Medavakam/15_m_po.webp',
        'assets/project_page/Residential Project/Medavakam/16_m_p.webp',
        'assets/project_page/Residential Project/Medavakam/17_m_fc.webp',
        'assets/project_page/Residential Project/Medavakam/18_m.webp',
        'assets/project_page/Residential Project/Medavakam/19_m.webp',
      ],
    ),
    ClientProject(
      name: 'Purasaiwakkam',
      thumbnail: 'assets/project_page/Residential Project/Purasaiwakkam/1_p.webp',
      galleryImages: [
        'assets/project_page/Residential Project/Purasaiwakkam/1_p.webp',
        'assets/project_page/Residential Project/Purasaiwakkam/2_p.webp',
        'assets/project_page/Residential Project/Purasaiwakkam/3_p_tv.webp',
        'assets/project_page/Residential Project/Purasaiwakkam/4_p.webp',
        'assets/project_page/Residential Project/Purasaiwakkam/5_p.webp',
        'assets/project_page/Residential Project/Purasaiwakkam/6_p_p.webp',
        'assets/project_page/Residential Project/Purasaiwakkam/7_p_po.webp',
        'assets/project_page/Residential Project/Purasaiwakkam/8_p_k.webp',
        'assets/project_page/Residential Project/Purasaiwakkam/9_p.webp',
        'assets/project_page/Residential Project/Purasaiwakkam/10_p_w.webp',
        'assets/project_page/Residential Project/Purasaiwakkam/11_p.webp',
        'assets/project_page/Residential Project/Purasaiwakkam/12_p_rr.webp',
        'assets/project_page/Residential Project/Purasaiwakkam/13_p.webp',
        'assets/project_page/Residential Project/Purasaiwakkam/14_p_w.webp',
        'assets/project_page/Residential Project/Purasaiwakkam/15_p.webp',
        'assets/project_page/Residential Project/Purasaiwakkam/16_p.webp',
        'assets/project_page/Residential Project/Purasaiwakkam/17_p_rr.webp',
      ],
    ),
    ClientProject(
      name: 'Vepambattu',
      thumbnail: 'assets/project_page/Residential Project/Vepambattu/1_vep.webp',
      galleryImages: [
        'assets/project_page/Residential Project/Vepambattu/1_vep.webp',
        'assets/project_page/Residential Project/Vepambattu/2_vep.webp',
        'assets/project_page/Residential Project/Vepambattu/3_vep_tv.webp',
        'assets/project_page/Residential Project/Vepambattu/4_vep.webp',
        'assets/project_page/Residential Project/Vepambattu/5_vep_k.webp',
        'assets/project_page/Residential Project/Vepambattu/6_vep_k.webp',
        'assets/project_page/Residential Project/Vepambattu/7_vep_w.webp',
        'assets/project_page/Residential Project/Vepambattu/8_vep_s.webp',
        'assets/project_page/Residential Project/Vepambattu/9_vep_s_w.webp',
        'assets/project_page/Residential Project/Vepambattu/10_vep_w.webp',
        'assets/project_page/Residential Project/Vepambattu/11_vep.webp',
      ],
    ),
    ClientProject(
      name: 'Vidhya',
      thumbnail: 'assets/project_page/Residential Project/Vidhya/1_v.webp',
      galleryImages: [
        'assets/project_page/Residential Project/Vidhya/1_v.webp',
        'assets/project_page/Residential Project/Vidhya/2_v.webp',
        'assets/project_page/Residential Project/Vidhya/3_v.webp',
        'assets/project_page/Residential Project/Vidhya/4_v.webp',
        'assets/project_page/Residential Project/Vidhya/5_v_tv.webp',
        'assets/project_page/Residential Project/Vidhya/6_v_k.webp',
        'assets/project_page/Residential Project/Vidhya/7_v.webp',
        'assets/project_page/Residential Project/Vidhya/8_v.webp',
        'assets/project_page/Residential Project/Vidhya/9_v_w.webp',
        'assets/project_page/Residential Project/Vidhya/10_v_w.webp',
        'assets/project_page/Residential Project/Vidhya/11_v_w.webp',
        'assets/project_page/Residential Project/Vidhya/12_v.webp',
      ],
    ),
    ClientProject(
      name: 'Nagaraj',
      thumbnail: 'assets/project_page/Residential Project/Nagaraj/1_n_fc.webp',
      galleryImages: [
        'assets/project_page/Residential Project/Nagaraj/1_n_fc.webp',
        'assets/project_page/Residential Project/Nagaraj/2_n.webp',
        'assets/project_page/Residential Project/Nagaraj/3_n_tv.webp',
        'assets/project_page/Residential Project/Nagaraj/4_n_po.webp',
        'assets/project_page/Residential Project/Nagaraj/5_n_fc.webp',
        'assets/project_page/Residential Project/Nagaraj/6_n_k.webp',
        'assets/project_page/Residential Project/Nagaraj/7_n_k.webp',
        'assets/project_page/Residential Project/Nagaraj/8_n_k.webp',
        'assets/project_page/Residential Project/Nagaraj/9_n.webp',
        'assets/project_page/Residential Project/Nagaraj/10_n_w.webp',
        'assets/project_page/Residential Project/Nagaraj/11_n_s.webp',
        'assets/project_page/Residential Project/Nagaraj/12_n.webp',
        'assets/project_page/Residential Project/Nagaraj/13_n_w.webp',
        'assets/project_page/Residential Project/Nagaraj/14_n_s.webp',
        'assets/project_page/Residential Project/Nagaraj/15_n.webp',
        'assets/project_page/Residential Project/Nagaraj/16_n_w.webp',
        'assets/project_page/Residential Project/Nagaraj/17_n_s.webp',
        'assets/project_page/Residential Project/Nagaraj/18_n.webp',
      ],
    ),

  ];

  final List<ClientProject> commercialClients = [
    ClientProject(
      name: 'Brakes India Bawal',
      thumbnail: 'assets/project_page/Commercial Project/Brakes India Bawal/1_bawal.webp',
      galleryImages: [
        'assets/project_page/Commercial Project/Brakes India Bawal/1_bawal.webp',
        'assets/project_page/Commercial Project/Brakes India Bawal/2_bawal_par.webp',
        'assets/project_page/Commercial Project/Brakes India Bawal/3_bawal.webp',
        'assets/project_page/Commercial Project/Brakes India Bawal/4_bawal.webp',
        'assets/project_page/Commercial Project/Brakes India Bawal/5_bawal_par.webp',
        'assets/project_page/Commercial Project/Brakes India Bawal/6_bawal_mf.webp',
        'assets/project_page/Commercial Project/Brakes India Bawal/7_bawal_mf.webp',
        'assets/project_page/Commercial Project/Brakes India Bawal/8_bawal_mf.webp',
        'assets/project_page/Commercial Project/Brakes India Bawal/9_bawal.webp',
        'assets/project_page/Commercial Project/Brakes India Bawal/10_bawal_mf.webp',
        'assets/project_page/Commercial Project/Brakes India Bawal/11_bawal_mf.webp',
        'assets/project_page/Commercial Project/Brakes India Bawal/12_bawal_mf.webp',
        'assets/project_page/Commercial Project/Brakes India Bawal/13_bawal_mf.webp',
        'assets/project_page/Commercial Project/Brakes India Bawal/14_bawal_mf.webp',
        'assets/project_page/Commercial Project/Brakes India Bawal/15_bawal_par.webp',
        'assets/project_page/Commercial Project/Brakes India Bawal/16_bawal_par.webp',
        'assets/project_page/Commercial Project/Brakes India Bawal/17_bawal.webp',
        'assets/project_page/Commercial Project/Brakes India Bawal/18_bawal.webp',
        'assets/project_page/Commercial Project/Brakes India Bawal/19_bawal.webp',
        'assets/project_page/Commercial Project/Brakes India Bawal/20_bawal.webp',
      ],
    ),

    ClientProject(
      name: 'Chetpet Office',
      thumbnail: 'assets/project_page/Commercial Project/Chetpet Office/1_chetpet.webp',
      galleryImages: [
        'assets/project_page/Commercial Project/Chetpet Office/1_chetpet.webp',
        'assets/project_page/Commercial Project/Chetpet Office/2_chetpet.webp',
        'assets/project_page/Commercial Project/Chetpet Office/3_chetpet.webp',
        'assets/project_page/Commercial Project/Chetpet Office/4_chetpet.webp',
        'assets/project_page/Commercial Project/Chetpet Office/5_chetpet_mf.webp',
        'assets/project_page/Commercial Project/Chetpet Office/6_chetpet_mf.webp',
        'assets/project_page/Commercial Project/Chetpet Office/7_chetpet.webp',
        'assets/project_page/Commercial Project/Chetpet Office/8_chetpet_mf.webp',
        'assets/project_page/Commercial Project/Chetpet Office/9_chetpet.webp',
        'assets/project_page/Commercial Project/Chetpet Office/10_chetpet.webp',
        'assets/project_page/Commercial Project/Chetpet Office/11_chetpet.webp',
      ],
    ),
    ClientProject(
      name: 'Egmore Showroom',
      thumbnail: 'assets/project_page/Commercial Project/Egmore Showroom/1_egmore.webp',
      galleryImages: [
        'assets/project_page/Commercial Project/Egmore Showroom/1_egmore.webp',
        'assets/project_page/Commercial Project/Egmore Showroom/2_egmore.webp',
        'assets/project_page/Commercial Project/Egmore Showroom/3_egmore.webp',
        'assets/project_page/Commercial Project/Egmore Showroom/4_egmore.webp',
        'assets/project_page/Commercial Project/Egmore Showroom/5_egmore.webp',
        'assets/project_page/Commercial Project/Egmore Showroom/6_egmore.webp',
        'assets/project_page/Commercial Project/Egmore Showroom/7_egmore.webp',
        'assets/project_page/Commercial Project/Egmore Showroom/8_egmore.webp',
        'assets/project_page/Commercial Project/Egmore Showroom/9_egmore.webp',
        'assets/project_page/Commercial Project/Egmore Showroom/10_egmore.webp',
        'assets/project_page/Commercial Project/Egmore Showroom/11_egmore.webp',
        'assets/project_page/Commercial Project/Egmore Showroom/12_egmore.webp',
        'assets/project_page/Commercial Project/Egmore Showroom/13_egmore.webp',
        'assets/project_page/Commercial Project/Egmore Showroom/14_egmore.webp',
      ],
    ),
    ClientProject(
      name: 'Muppad Assembly',
      thumbnail: 'assets/project_page/Commercial Project/Muppad Assembly/1_mup.webp',
      galleryImages: [
        'assets/project_page/Commercial Project/Muppad Assembly/1_mup.webp',
        'assets/project_page/Commercial Project/Muppad Assembly/2_mup.webp',
        'assets/project_page/Commercial Project/Muppad Assembly/3_mup.webp',
        'assets/project_page/Commercial Project/Muppad Assembly/4_mup.webp',
        'assets/project_page/Commercial Project/Muppad Assembly/5_mup.webp',
        'assets/project_page/Commercial Project/Muppad Assembly/6_mup.webp',
        'assets/project_page/Commercial Project/Muppad Assembly/7_mup.webp',
        'assets/project_page/Commercial Project/Muppad Assembly/8_mup.webp',
      ],
    ),
    ClientProject(
      name: 'OP Mobility Canteen',
      thumbnail: 'assets/project_page/Commercial Project/OP Mobility Canteen/1_opcanteen.webp',
      galleryImages: [
        'assets/project_page/Commercial Project/OP Mobility Canteen/1_opcanteen.webp',
        'assets/project_page/Commercial Project/OP Mobility Canteen/2_opcanteen.webp',
        'assets/project_page/Commercial Project/OP Mobility Canteen/3_opcanteen.webp',
        'assets/project_page/Commercial Project/OP Mobility Canteen/4_opcanteen.webp',
        'assets/project_page/Commercial Project/OP Mobility Canteen/6_opcanteen.webp',
        'assets/project_page/Commercial Project/OP Mobility Canteen/7_opcanteen.webp',
      ],
    ),
    ClientProject(
      name: 'OP Mobility Display',
      thumbnail: 'assets/project_page/Commercial Project/OP Mobility Display/1_opm.webp',
      galleryImages: [
        'assets/project_page/Commercial Project/OP Mobility Display/1_opm.webp',
        'assets/project_page/Commercial Project/OP Mobility Display/2_opm.webp',
        'assets/project_page/Commercial Project/OP Mobility Display/3_opm.webp',
        'assets/project_page/Commercial Project/OP Mobility Display/4_opm.webp',
      ],
    ),
    ClientProject(
      name: 'Universal',
      thumbnail: 'assets/project_page/Commercial Project/Universal/1_uni.webp',
      galleryImages: [
        'assets/project_page/Commercial Project/Universal/1_uni.webp',
        'assets/project_page/Commercial Project/Universal/2_uni.webp',
        'assets/project_page/Commercial Project/Universal/3_uni_par.webp',
        'assets/project_page/Commercial Project/Universal/4_uni_mf.webp',
        'assets/project_page/Commercial Project/Universal/5_uni_mf.webp',
      ],
    ),
    ClientProject(
      name: 'TIDC',
      thumbnail: 'assets/project_page/Commercial Project/TIDC/2_tidc.webp',
      galleryImages: [
        'assets/project_page/Commercial Project/TIDC/1_tidc_mf.webp',
        'assets/project_page/Commercial Project/TIDC/2_tidc.webp',
        'assets/project_page/Commercial Project/TIDC/3_tidc_par.webp',
        'assets/project_page/Commercial Project/TIDC/4_tidc_mf.webp',
        'assets/project_page/Commercial Project/TIDC/5_tidc_mf.webp',
        'assets/project_page/Commercial Project/TIDC/6_tidc.webp',
        'assets/project_page/Commercial Project/TIDC/7_tidc.webp',
        'assets/project_page/Commercial Project/TIDC/8_tidc.webp',
        'assets/project_page/Commercial Project/TIDC/9_tidc_mf.webp',
        'assets/project_page/Commercial Project/TIDC/10_tidc.webp',
      ],
    ),
  ];
  void _openClientGallery(List<String> images, int initialIndex) {
    int currentIndex = initialIndex;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Scaffold(
                backgroundColor: Colors.black87,
                body: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: images[currentIndex].startsWith('http')
                            ? Image.network(
                          images[currentIndex],
                          fit: BoxFit.contain,
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.7,
                        )
                            : Image.asset(
                          images[currentIndex],
                          fit: BoxFit.contain,
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.7,
                        ),
                      ),
                      Positioned(
                        left: 20,
                        child: IconButton(
                          iconSize: 40,
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              currentIndex = (currentIndex - 1 + images.length) % images.length;
                            });
                          },
                        ),
                      ),
                      Positioned(
                        right: 20,
                        child: IconButton(
                          iconSize: 40,
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              currentIndex = (currentIndex + 1) % images.length;
                            });
                          },
                        ),
                      ),
                      Positioned(
                        top: 40,
                        right: 20,
                        child: IconButton(
                          iconSize: 30,
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildClientGrid(List<ClientProject> clients) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 4 / 3,
      ),
      itemCount: clients.length,
      itemBuilder: (context, index) {
        final client = clients[index];
        final hoverEffect = _projectHoverEffects[client.name] ?? 'scale';

        return _HoverImageCard(
          imagePath: client.thumbnail,
          title: client.name,
          onButtonPressed: () => _openClientGallery(client.galleryImages, 0),
          transitionType: hoverEffect,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 220,
                  child: Image.asset(
                    'assets/modular_kitchen.webp',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 220,
                  color: Colors.black.withOpacity(0.3),
                ),
                Positioned(
                  left: 40,
                  top: 80,
                  child: const Text(
                    'We Brings Your Dream Into Reality',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  right: 40,
                  top: 80,
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const HomePage()),
                          );
                        },
                        child: const Text(
                          'HOME',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'GALLERY',
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Our Works',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 2,
                        width: 60,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.circle_outlined,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        height: 2,
                        width: 60,
                        color: theme.colorScheme.primary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Center(
                    child: TabBar(
                      indicatorColor: theme.colorScheme.primary,
                      labelColor: theme.colorScheme.primary,
                      unselectedLabelColor: theme.disabledColor,
                      tabs: const [
                        Tab(child: Text('All', style: TextStyle(fontSize: 16))),
                        Tab(
                          child: Text(
                            'Residential',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Commercial',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, thickness: 1),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildClientGrid([
                          ...residentialClients,
                          ...commercialClients,
                        ]),
                        _buildClientGrid(residentialClients),
                        _buildClientGrid(commercialClients),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HoverImageCard extends StatefulWidget {
  final String imagePath;
  final VoidCallback onButtonPressed;
  final String? title;
  final String transitionType;

  const _HoverImageCard({
    required this.imagePath,
    required this.onButtonPressed,
    this.title,
    required this.transitionType,
    Key? key,
  }) : super(key: key);

  @override
  State<_HoverImageCard> createState() => _HoverImageCardState();
}

class _HoverImageCardState extends State<_HoverImageCard> {
  bool _isHovered = false;

  Widget _buildTransitionEffect(Widget child) {
    switch (widget.transitionType) {
      case 'slide_left_right':
        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          transform: Matrix4.identity()..translate(_isHovered ? 10.0 : 0.0, 0.0),
          child: child,
        );

      case 'slide_right_left':
        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          transform: Matrix4.identity()..translate(_isHovered ? -10.0 : 0.0, 0.0),
          child: child,
        );

      case 'slide_up_down':
        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          transform: Matrix4.identity()..translate(0.0, _isHovered ? -10.0 : 0.0),
          child: child,
        );

      case 'slide_down_up':
        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          transform: Matrix4.identity()..translate(0.0, _isHovered ? 10.0 : 0.0),
          child: child,
        );

      case 'reveal_left':
        return Stack(
          children: [
            child,
            Positioned.fill(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.centerLeft,
                clipBehavior: Clip.none,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: _isHovered ? 0 : MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        );

      case 'reveal_right':
        return Stack(
          children: [
            child,
            Positioned.fill(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.centerRight,
                clipBehavior: Clip.none,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: _isHovered ? 0 : MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        );

      case 'reveal_top':
        return Stack(
          children: [
            child,
            Positioned.fill(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  height: _isHovered ? 0 : MediaQuery.of(context).size.height,
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        );

      case 'reveal_bottom':
        return Stack(
          children: [
            child,
            Positioned.fill(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  height: _isHovered ? 0 : MediaQuery.of(context).size.height,
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        );

      case 'wipe_left':
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              child,
              Positioned.fill(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  color: Colors.black.withOpacity(0.6),
                  alignment: Alignment.centerRight,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    width: _isHovered ? 0 : MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        );
      case 'scale':
        return AnimatedScale(
          duration: const Duration(milliseconds: 300),
          scale: _isHovered ? 1.05 : 1.0,
          curve: Curves.easeInOut,
          child: child,
        );
      case 'fade':
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _isHovered ? 0.7 : 1.0,
          curve: Curves.easeInOut,
          child: child,
        );
      case 'blur':
        return Stack(
          children: [
            child,
            if (_isHovered)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                  child: Container(),
                ),
              ),
          ],
        );
      case 'rotate':
        return AnimatedRotation(
          duration: const Duration(milliseconds: 400),
          turns: _isHovered ? 0.01 : 0.0,
          curve: Curves.easeInOut,
          child: child,
        );

      case 'brightness':
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _isHovered ? Colors.black.withOpacity(0.2) : Colors.transparent,
          ),
          child: child,
        );
      default:
        return child;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: _buildTransitionEffect(
              Image.asset(
                widget.imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _isHovered ? 1.0 : 0.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(100),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.title != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                       "Arch Interior",
                        style: const TextStyle(
                          color: Colors.white,

                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withAlpha(230),
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(12),
                      elevation: 2,
                    ),
                    onPressed: widget.onButtonPressed,
                    child: const Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}