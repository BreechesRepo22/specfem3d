!=====================================================================
!
!          S p e c f e m 3 D  B a s i n  V e r s i o n  1 . 1
!          --------------------------------------------------
!
!                 Dimitri Komatitsch and Jeroen Tromp
!    Seismological Laboratory - California Institute of Technology
!         (c) California Institute of Technology October 2002
!
!    A signed non-commercial agreement is required to use this program.
!   Please check http://www.gps.caltech.edu/research/jtromp for details.
!           Free for non-commercial academic research ONLY.
!      This program is distributed WITHOUT ANY WARRANTY whatsoever.
!      Do not redistribute this program without written permission.
!
!=====================================================================

! create file OUTPUT_FILES/values_from_mesher.h based upon DATA/Par_file
! in order to compile the solver with the right array sizes

  program create_header_file

  implicit none

  include "constants.h"

  integer NER_SEDIM,NER_BASEMENT_SEDIM,NER_16_BASEMENT,NER_MOHO_16,NER_BOTTOM_MOHO, &
            NEX_ETA,NEX_XI,NPROC_ETA,NPROC_XI,NSEIS,NSTEP,UTM_PROJECTION_ZONE
  integer NSOURCES

! parameters to be computed based upon parameters above read from file
  integer NPROC,NEX_PER_PROC_XI,NEX_PER_PROC_ETA,NER

  integer NSPEC_AB,NSPEC2D_A_XI,NSPEC2D_B_XI, &
      NSPEC2D_A_ETA,NSPEC2D_B_ETA, &
      NSPEC2DMAX_XMIN_XMAX,NSPEC2DMAX_YMIN_YMAX,NSPEC2D_BOTTOM,NSPEC2D_TOP, &
      NPOIN2DMAX_XMIN_XMAX,NPOIN2DMAX_YMIN_YMAX,NGLOB_AB

  double precision UTM_X_MIN,UTM_X_MAX,UTM_Y_MIN,UTM_Y_MAX,Z_DEPTH_BLOCK
  double precision LAT_MIN,LAT_MAX,LONG_MIN,LONG_MAX,DT
  double precision THICKNESS_TAPER_BLOCKS,VP_MIN_GOCAD,VP_VS_RATIO_GOCAD_TOP,VP_VS_RATIO_GOCAD_BOTTOM

  logical HARVARD_3D_GOCAD_MODEL,TOPOGRAPHY,ATTENUATION, &
          OCEANS,IMPOSE_MINIMUM_VP_GOCAD,HAUKSSON_REGIONAL_MODEL, &
          BASEMENT_MAP,MOHO_MAP_LUPEI,STACEY_ABS_CONDITIONS

  logical SAVE_AVS_DX_MOVIE,SAVE_DISPLACEMENT
  integer NMOVIE
  double precision HDUR_MIN_MOVIES

  character(len=150) LOCAL_PATH

! ************** PROGRAM STARTS HERE **************

  print *
  print *,'creating file OUTPUT_FILES/values_from_mesher.h to compile solver with correct values'

! read the parameter file
  call read_parameter_file(LAT_MIN,LAT_MAX,LONG_MIN,LONG_MAX, &
        UTM_X_MIN,UTM_X_MAX,UTM_Y_MIN,UTM_Y_MAX,Z_DEPTH_BLOCK, &
        NER_SEDIM,NER_BASEMENT_SEDIM,NER_16_BASEMENT,NER_MOHO_16,NER_BOTTOM_MOHO, &
        NEX_ETA,NEX_XI,NPROC_ETA,NPROC_XI,NSEIS,NSTEP,UTM_PROJECTION_ZONE,DT, &
        ATTENUATION,HARVARD_3D_GOCAD_MODEL,TOPOGRAPHY,LOCAL_PATH,NSOURCES, &
        THICKNESS_TAPER_BLOCKS,VP_MIN_GOCAD,VP_VS_RATIO_GOCAD_TOP,VP_VS_RATIO_GOCAD_BOTTOM, &
        OCEANS,IMPOSE_MINIMUM_VP_GOCAD,HAUKSSON_REGIONAL_MODEL, &
        BASEMENT_MAP,MOHO_MAP_LUPEI,STACEY_ABS_CONDITIONS, &
        SAVE_AVS_DX_MOVIE,SAVE_DISPLACEMENT,NMOVIE,HDUR_MIN_MOVIES)

! compute other parameters based upon values read
  call compute_parameters(NER,NEX_XI,NEX_ETA,NPROC_XI,NPROC_ETA, &
      NPROC,NEX_PER_PROC_XI,NEX_PER_PROC_ETA, &
      NER_BOTTOM_MOHO,NER_MOHO_16,NER_16_BASEMENT,NER_BASEMENT_SEDIM,NER_SEDIM, &
      NSPEC_AB,NSPEC2D_A_XI,NSPEC2D_B_XI, &
      NSPEC2D_A_ETA,NSPEC2D_B_ETA, &
      NSPEC2DMAX_XMIN_XMAX,NSPEC2DMAX_YMIN_YMAX,NSPEC2D_BOTTOM,NSPEC2D_TOP, &
      NPOIN2DMAX_XMIN_XMAX,NPOIN2DMAX_YMIN_YMAX,NGLOB_AB)

! create include file for the solver
  call save_header_file(NSPEC_AB,NGLOB_AB,NEX_XI,NEX_ETA,NPROC,UTM_X_MIN,UTM_X_MAX,UTM_Y_MIN,UTM_Y_MAX,ATTENUATION)

  print *
  print *,'edit file OUTPUT_FILES/values_from_mesher.h to see some statistics about the mesh'
  print *
  print *,'on NEC SX-5 and Earth Simulator, make sure "loopcnt=" parameter'
  print *,'in Makefile is greater than max vector length = ',NGLOB_AB

  print *
  print *,'done'
  print *

  end program create_header_file

